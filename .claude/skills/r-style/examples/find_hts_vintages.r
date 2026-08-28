VINTAGE_MAX_PASSES <- 10

.vintage_cache <- new.env(parent = emptyenv())
.vintage_answers <- new.env(parent = emptyenv())

find_hts_vintages <- function(statutory_codes, data_window_start, data_window_end) {
  # 484(f) procedure only modifies 10-digit codes, so we can omit shorter codes from this crosswalk procedure.
  statutory_codes_10digit <- unique(statutory_codes[nchar(statutory_codes) == 10])

  cache_key <- paste(data_window_start, data_window_end, paste(sort(statutory_codes_10digit), collapse = ","))
  if (!is.null(.vintage_answers[[cache_key]])) return(.vintage_answers[[cache_key]])

  if (!is.null(.vintage_cache$history)) {
    code_history <- .vintage_cache$history
  } else {
    code_history <-
      readr::read_csv(paste0(path_lookup, "hts_code_history.csv")) |>
      mutate(
        across(c(old_code, new_code), ~ gsub("[.]", "", .x)),
        effective_date = as.Date(effective_date, "%Y/%m/%d")
      )
    .vintage_cache$history <- code_history
  }

  # We are crosswalking statutory codes to both predecessors (if the policy is newer than trade data, which is the common use case), but also to successors (if the policy is older than trade data, which can happen as we swtich to new trade data in the future), which is why we need two pairs of named lists. Each pair is the vintage codes and the migration date; "vintage codes" refers to the "other" set of codes, i.e., they refer to the successor codes when the list is keyed by predecessor codes, and vice versa.
  lookup <- list(
    by_successor = list(
      # Named list of vintage codes, keyed by successor
      vintage_code = split(code_history$old_code, code_history$new_code),
      # Nmaed list of migration dates, keyed by successor
      migration_date = split(code_history$effective_date, code_history$new_code)
    ),
    by_predecessor = list(
      vintage_code = split(code_history$new_code, code_history$old_code),
      migration_date = split(code_history$effective_date, code_history$old_code)
    )
   
  )

  recursive_match <- function(is_keyed_by) {
    main_key <- is_keyed_by
    other_key <- setdiff(c("by_successor", "by_predecessor"), main_key)
    accumulated_codes <- statutory_codes

    truncate_history <- function(main_key) {
      # Consider the common case where the policy is newer. More specifically, it is after the start of the data window. We would want to keep all migrations whose date is after the start of the data window. We can disregard the migrations whose date is before the start of the data window. We will then match statutory codes, successor->predecessor.
      if (main_key == "by_successor") {
        is_timely_migration <- sapply(
          lookup[[main_key]]$migration_date, \(v) max(v) >= data_window_start
        )
        is_timely_migration_other <- sapply(
          lookup[[other_key]]$migration_date, \(v) max(v) >= data_window_start
        )
      } else if (main_key == "by_predecessor") {
      # Consider the case where the data is newer. More specifically, the statute is drafted before the end of the data window. We would want to keep all migrations whose date is before the end of the data window. We can disregard the migrations whose date is after the start of the data window. We will then match statutory codes, predecessor->successor
        is_timely_migration <- sapply(
          lookup[[main_key]]$migration_date, \(v) min(v) <= data_window_end
        )
        is_timely_migration_other <- sapply(
          lookup[[other_key]]$migration_date, \(v) min(v) <= data_window_end
        )
      }
      main_map <- lookup[[main_key]]$vintage_code[is_timely_migration]
      reverse_map <- lookup[[other_key]]$vintage_code[is_timely_migration_other]

      return(
        list(
          main_map = main_map,
          reverse_map = reverse_map
        )
      )
    }

    # Starting from here, operations are symmetric for both predecesesor->successor and successor->predecessor matches.
    maps <- truncate_history(main_key)
    main_map <- maps$main_map

    for (pass in seq_len(VINTAGE_MAX_PASSES)) {
      start_code_n <- length(accumulated_codes)
      matched_vintages <- unlist(main_map[names(main_map) %in% accumulated_codes], use.names = FALSE)

      # In the successor->predecessor case, a code split is the issue (more specifically, one predecessor splits into multiple successor), since any matches to predecessor by a *single* successor does not imply the entire predecessor is tariffed. In the predecessor->successor case, a code merge is the issue (more specifically, multiple predecessors merge into one successor), since any matches to successor by a *single* predecessor does not imply the entire successor is tariffed.
      vintages_children <- 
        maps$reverse_map[names(maps$reverse_map) %in% matched_vintages] %>%
        .[lengths(.) > 1]
      
      is_all_children_present <- 
        sapply(vintages_children, \(v) all(v %in% accumulated_codes))

      eliminated_vintages <- names(vintages_children)[!is_all_children_present]

      vintages_to_add <- setdiff(
        matched_vintages, 
        # Add accumulated_codes to remove already-accumulated codes.
        c(eliminated_vintages, accumulated_codes)
      )

      accumulated_codes <- c(accumulated_codes, vintages_to_add)
      end_code_n <- length(accumulated_codes)

      if (end_code_n - start_code_n <= 0) break
    }

    return(accumulated_codes)
  }

  statutory_codes <- recursive_match("by_successor")
  statutory_codes <- recursive_match("by_predecessor")

  .vintage_answers[[cache_key]] <- statutory_codes
  return(statutory_codes)
}
