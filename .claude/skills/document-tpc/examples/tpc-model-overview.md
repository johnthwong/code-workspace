The Urban-Brookings Tax Policy Center (TPC) large-scale microsimulation model produces estimates of how current and proposed tax policies will affect federal revenues and the distribution of tax burdens by income. The model is similar to those used by the Congressional Budget Office (CBO), the Joint Committee on Taxation (JCT), and the Treasury's Office of Tax Analysis (OTA).

The current version of the TPC tax model produces revenue and distributional estimates for each individual year from 2011 to 2031 (the end of a ten-year budget window starting in 2022). In addition, TPC’s long-run module provides estimates at ten-year intervals from 2040 through 2090. Another module calculates how federal tax policy changes affect taxpayers in each state for the current year and a few selected years within the ten-year budget window.

I. Tax Model Database

The model’s primary data source is the 2006 public-use file (PUF) produced by the Statistics of Income (SOI) Division of the Internal Revenue Service (IRS). The 2006 PUF contains 145,858 records with detailed information from federal individual income tax returns from tax years 2003 to 2006 filed in the calendar year 2007.[i] 

To begin with, we use cross-tabulations of age, filing status, and income sources provided to us by SOI and implement a raking algorithm to impute the ages of taxpayers and their dependents onto the 2006 PUF.[ii] Then, we employ a two-step process to create a file that is nationally and state representative of the tax filing population for the 2011 tax year.[iii] 

In the first step of this process, we use published tax data to calculate per-return average growth rates for income, deductions, and other items between 2006 and 2011 by adjusted gross income (AGI) class. We then use these growth rates to adjust the dollar amounts on each PUF record. In the second step of the process, we use a constrained optimization algorithm to reweight the records in order to match an extensive set of about 100 national targets and 39 to 51 state targets for both return counts and dollar amounts.[iv]

We refer to the resulting file as the 2011 “Look-Alike Public Use File” or LAPUF. We add to that file information on other demographic characteristics and sources of income that are not reported on tax returns through a constrained statistical match with 2011 data from the US Census Bureau’s March 2012 Current Population Survey (CPS).

That match also generates a sample of individuals who do not file individual income tax returns (“non-filers”). The data set combining filers from the LAPUF (augmented by demographic and other information from the CPS) and non-filers from the CPS provides us with a representative sample of the entire population rather than just the segment that files income tax returns. This allows us to estimate the revenue and distributional impact of tax proposals (such as refundable tax credits) that would potentially affect current non-filers.

Finally, we augment the tax model database by imputing wealth, education, consumption, health, retirement, and other variables for each record in the matched LAPUF-CPS file. We also impute state weights for each record to enable an analysis of federal and state tax policies’ impacts at the state level. Note that each record in the tax model database represents a tax unit. A tax unit is an individual or a married couple that files a tax return, or would file a tax return if their income were high enough, along with all dependents of that individual or married couple.

A. Wealth Imputations

Because the income tax data in our model contain no direct information about wealth holdings, we rely on information from the 2016 Survey of Consumer Finances (SCF) to develop imputations for 18 categories of assets and debt.[v]

For each of these wealth components, we run probit and ordinary least squares (OLS) regressions against explanatory variables that exist in both the SCF and the tax model database. We use predicted probabilities from the probit regressions to estimate whether if a record will report a positive value for that item. For records with a positive projected value, we use the OLS regression coefficients to assign an amount.

We then calibrate the imputed number of tax units with a positive amount of each item, as well as the aggregate amount and distribution by income of each item, to match targets we create. For most variables, we base the targets on SCF data, but in certain cases, such as farm assets and debt, we rely on alternative data sources such as the Department of Agriculture.

Finally, we employ an adjustment algorithm and iterate to ensure that the overall distribution of net worth by the size of net worth holdings closely matches the distribution in the SCF, while ensuring that the distribution of each wealth component by income also remains consistent with the SCF data.

Because the SCF, by design, excludes the 400 wealthiest individuals – the “Forbes 400” – we impute their wealth using a different technique. Using published information for the 2016 Forbes 400, we categorize each member by age, marital status, and primary source of wealth. We then match these individuals to tax model records with the same marital status and age and with reported income consistent with the wealth profile reported by Forbes.

This process generates 400 tax model records flagged as tax units with Forbes individuals and with these individuals’ associated net worth as reported by Forbes imputed to the tax units. We then assign asset and debt items consistent with that net worth by matching to similar records in the SCF with very high net worth. Finally, we apply the shares for each asset and debt item from the matched SCF record to the tax model record to impute detailed assets and debts.

B. Education Imputations

To build the capacity to model tax incentives for education and their interaction with Pell Grants and other federal assistance to post-secondary students, we impute student characteristics to the tax model. First, we use data from the 2011-2012 National Postsecondary Student Aid Study (NPSAS)[vi] combined with an indicator from the LAPUF as to whether a particular tax unit reported education tax incentives (such as the Lifetime Learning Credit or the above-the-line deduction for education expenses) to impute the presence of post-secondary students to each record in the database.

We then use the NPSAS to impute student characteristics –such as enrollment status, class year, and institution type – as well as education expenses – including tuition and fees, books, room and board, and transportation. We use these imputed characteristics to calculate potential education tax incentives and Pell Grants and assign take-up rates in order to match actual tabulations by income from SOI and the Department of Education.

C. Consumption Imputations

To have the capacity to model the distributional impacts of federal excise taxes and other indirect taxes, including broad-based consumption taxes (e.g., a value-added tax) and environmental taxes, we impute consumption spending to each record in the tax model database. We use data from the Consumer Expenditure Survey (CEX) to produce estimates of consumption expenditures across 16 categories of goods and services for each tax unit in the tax model.

We also use the Urban Institute’s Dynamic Simulation of Income Model (DYNASIM3) to estimate future consumption financed out of current wealth. DYNASIM3 is a dynamic microsimulation model that is designed specifically to project the population and analyze the long-run distributional effects of retirement and other aging issues.[vii] This allows us to analyze transitional issues that arise in moving from an income- to a consumption-based tax system as proposed under some comprehensive reform options.

D. Health Imputations

To be able to analyze tax subsidies for health insurance and medical expenses – such as tax expenditures for employer-provided health benefits, tax credits for non-group insurance purchased through Affordable Care Act (ACA) marketplaces, and the ACA penalty on employers offering insufficient health insurance coverage –we impute health insurance status and employer-provided health benefits to each record in our database.

We impute health insurance status using a statistical match with the Urban Institute’s Health Insurance Policy Simulation Model (HIPSM).[viii] HIPSM is a detailed microsimulation model of the health care system designed to estimate the cost and coverage effects of proposed health care policy options.[ix]

We impute employer-provided health benefits by statistically matching tax units with employer-sponsored health insurance to employers offering health coverage in the 2015, 2017, and 2018 Kaiser/HRET employer surveys.[x] We impute employer and employee contributions for health, dental and vision insurance; Health Savings Accounts; Health Reimbursement Arrangements; and Medical Flexible Spending Accounts.

E. Retirement Imputations

To be able to analyze the revenue and distributional implications of tax measures related to retirement savings, we impute a comprehensive set of pension and retirement savings variables to each tax unit in the tax model database. These variables include, when relevant, eligibility, contribution amounts, accrued benefits, and asset balances of each taxpayer’s defined benefit pension, a defined contribution pension, and an Individual Retirement Arrangement (IRA). We rely on information from the SCF to impute pension characteristics as well as pension and IRA asset balances, and we use SOI data to impute IRA characteristics. We supplement and calibrate these imputations based on information from a number of official economic reports and projections.[xi]

F. Other Imputations

To complete the tax model database, we perform a number of other imputations. First, we use tabulations from the TRIM3 microsimulation model to adjust the reported values of certain non-taxable transfer payments.[xii] The reported values obtained through our statistical match with the CPS generally undercount both the number of recipients and total dollar amounts for food stamps (SNAP), Temporary Assistance for Needy Families (TANF), and Supplement Security Income (SSI). We therefore adjust our counts and amounts to match the TRIM3 reported values more closely.

We also impute mortgage interest on second homes and deductible interest on home equity loans. In addition, the model contains imputations for all itemizable deductions—including charitable contributions, medical expenses, and home mortgage interest—for “non-itemizers,” people who claim the standard deduction on their tax return. These imputations allow us to model the distribution and revenue implications of proposals to replace certain deductions with credits that would be available to all taxpayers regardless of itemization status.

To be able to estimate proposals that would tax unrealized gains on assets held at death, we use data from the 2019 SCF to impute unrealized capital gains for records in the tax model. We use a statistical match between the tax model database and the SCF to impute the ratio of unrealized gains to asset values for the four types of unrealized gains reported in the SCF: primary residence; other real estate; stocks and mutual funds; and businesses. After the match, we employ an adjustment algorithm to ensure that the amounts and distribution of unrealized gains in the tax model match those in the source data.

G. State Weights

To perform state-level analyses, we create additional weights to make the tax model database representative for each of the 50 states, the District of Columbia, and other areas.[xiii] We impute these 52 state weights to the tax model database using a method that guarantees each state’s weighted totals of chosen observed characteristics will match state targets. For years in which published IRS tax return data are available by state, targets come from these publications. When IRS data are not available by state, targets are detailed projections based on available IRS data and macroeconomic assumptions.[xiv]

II. Aging and Extrapolation Process

A. The Annual Adjustment Algorithm

The full tax model database is a representative national sample of the population for calendar year 2011. In order to carry out revenue and distribution analysis for future years, we “extrapolate” or “age” the 2011 data. For that purpose we use the actual 2012 through 2018 tax data available at the time we developed the database (mid-2021) as well as projections from a number of sources.

For the years from 2012 to 2031, we age the data based on

CBO forecasts and projections for growth of various types of income;
CBO and JCT baseline revenue projections;
IRS estimates of future growth in the number of tax returns;
CBO and JCT estimates of the distribution of tax units by income;
Census data on the size and age-composition of the population;
Department of Education projections for growth in tuition and the number of post-secondary students;
and CBO projections for growth in health care costs and personal consumption expenditures.
A two-step process produces a representative sample of the filing and non-filing populations in years beyond 2011. We first inflate the dollar amounts of income, adjustments, deductions, and credits on each record by their appropriate forecasted per capita growth rates. We use CBO’s forecast for per capita growth of each major income source, such as wages, capital gains, and other forms of non-wage income (interest and dividends, business income, taxable pensions, Social Security benefits, and others).[xv] We assume that most other items grow at CBO’s projected growth rate for per capita personal income.

In the second stage of the extrapolation, we use a linear programming algorithm to adjust the weights on each record so that the major income items, adjustments, and deductions match aggregate targets. We also attempt to adjust the overall distribution of adjusted gross income (AGI) to match published information from the Statistics of Income (SOI) division of the Internal Revenue Service (IRS) for 2012 through 2018, and projections from CBO for years from 2019 through 2031.

We use a similar two-stage technique in the long-run module to age the data for each ten-year increment between 2040 and 2090. For 2040 and beyond, we rely primarily on projections from CBO and from DYNASIM3.

In the first stage of the long-run aging process, we use CBO’s long-run inflation assumptions together with DYNASIM3 projections for the real growth in major income items such as wages and salaries, business income, capital income, pension income, and Social Security benefits, to grow the dollar amounts on the records in the tax model database.

In the second stage of the long-run extrapolation, we use our linear programming algorithm to adjust the weights on each record so that the major income amounts and certain other items match aggregate targets derived from the DYNASIM3 and CBO forecasts. For example, we determine long-run targets for health insurance coverage and the number of post-secondary students by applying the demographic trends from DYNASIM3 to the health insurance status and student counts generated by the tax model for 2031. Similarly, we derive long-run targets for retirement coverage and contributions from a combination of CBO projections and the baseline imputations in the tax model.

We also use the second-stage reweighting algorithm to match DYNASIM3 targets for the age distribution of the population and other demographic characteristics, including the number of married and single tax units.

Finally, we use the reweighting process to target the distribution of tax units by income as projected by DYNASIM3, adjusted to match CBO’s projected individual income tax revenue through 2040. For years after 2040, we rely exclusively on DYNASIM3’s projection of changes in the income distribution.

The annual update also incorporates new imputations for wealth, education, consumption, health, retirement, and other factors, based on the latest available data.

B. An Interim Adjustment Algorithm

Due to its complexity, we generally employ the annual adjustment algorithm just once a year, typically after CBO releases its Budget and Economic Outlook in late January or early February. However, when economic circumstances change dramatically (as they have during the ongoing pandemic), CBO may substantially revise its economic projections during the year.

To expeditiously and accurately incorporate these revisions, we have developed an interim adjustment algorithm to update the tax model baseline database and tax parameters of the relevant annually updated tax model. Specifically, using the original CBO projections incorporated in the annually updated tax model as a benchmark, we derive additional aging factors from the revised CBO economic projections and apply these factors to further inflate the dollar amounts and tax parameters in the annually updated tax model.

However, we implement only a simple linear programming algorithm to further adjust the weights on each record to match the revised numbers of people, workers and unemployed. This speedy, albeit less sophisticated, algorithm allows us to provide the most accurate possible estimates of a proposed tax policy’s impacts in a timely manner.

III. Tax Calculators

The tax model includes a set of detailed tax calculators that: (a) compute individual income tax liability for all tax units in the sample under current law and under alternative policy proposals; (b) compute the employee and employer shares of payroll taxes for Social Security and Medicare; (c) assign the burden of the corporate income tax and excise taxes to tax units; and (d) determine the expected value of estate tax liability for each tax unit in the sample using an estate tax calculator in combination with age-specific mortality rates.

A. Individual Income Tax Calculator

Based on the extrapolated data set, we can simulate policy options using a detailed tax calculator that captures most features of the federal individual income tax system, including the alternative minimum tax (AMT). The model's current law baseline reflects major income tax legislation enacted through October 2021, including the American Rescue Plan (ARP) Act of 2021, the Coronavirus Aid, Relief, and. Economic Security (CARES) Act of 2020, and the 2017 Tax Act commonly referred to as the Tax Cuts and Jobs Act (TCJA).

The 2017 Tax Act made significant changes to the individual income tax that required substantial revisions to the TPC model. Simulating the provisions in TCJA also required several new imputations for items such as domestic qualified business income. Whenever possible, we attempt to calibrate our imputations to published distribution or revenue estimates from JCT.

In addition to the federal individual income tax calculator, TPC has separately developed income tax calculators for the District of Columbia and the 43 states with income taxes. The state calculators cover the current year and a few selected years within the ten-year budget window. Those state calculators rely on the same database used in TPC’s federal model. Separate state weights have been developed to make the data representative for each state and the District of Columbia.[xvi] Note that our standard federal distribution tables do not include state taxes.

In our distribution tables, we assume that the burden of the individual income tax falls on the payer. CBO, JCT, and Treasury all use the same assumption.

B. Payroll Tax Calculator

Using the extrapolated data set, we also calculate federal payroll taxes for Social Security and Medicare. One complication is that our tax return data only provide information on combined earnings for married couples whereas payroll taxes are based on individual earnings.

The division between primary and secondary taxpayers’ earnings matters because the amount of individual earnings subject to the Social Security portion of payroll taxes is capped at $142,800 for 2021, a limit that is indexed annually based on wage growth. For married couples, we therefore assign earnings to each individual based on the split in wages observed on the CPS record to which the LAPUF record was matched.

In our distribution tables, we assume that workers bear the burden of both the employer and employee portions of payroll taxes. This premise is widely accepted among economists. CBO, JCT, and Treasury all make the same assumption for their distributional analyses.

C. Assigning Corporate Tax Burden to Individuals

Although firms pay the corporate income tax, the economic incidence of the tax falls on individuals. TPC’s tax model therefore distributes the corporate income tax burden to individuals. The incidence of the corporate tax, however, is an unsettled theoretical issue. The tax could be borne by the owners of corporate stock, or passed on in part to labor in the form of lower real wages, to consumers in the form of higher prices, or to the owners of some or all capital in the form of lower real rates of return.

In September 2012, we updated the assumptions used to distribute the corporate income tax: we now estimate that 60 percent is borne by shareholders, 20 percent by all capital owners, and 20 percent by labor. (Previously, we assumed that the entire burden fell on all owners of capital.) Based on our review of research on the issue, we do not assign any of the burden to consumers. Our current assumptions are similar to those now made by CBO, Treasury, and JCT.

We rely on CBO for our projections of baseline corporate tax liability and, when available, on JCT estimates of changes in corporate tax liability that would result from tax proposals.

D. Estate Tax

Our modeling of the estate tax begins with our SCF-based wealth imputations, which we adjust using SOI data so that they align more closely with the assets and liabilities actually reported on estate tax returns. We then assign values for most estate tax deductions and credits based on averages calculated from SOI estate tax data.

Our estate tax calculator then determines potential estate tax liability for each record in the database, based on the values for gross estate, deductions, and credits and the relevant estate tax rates and brackets. Finally, we multiply the calculated tax liabilities by age-specific mortality rates to estimate each record's expected value of gross estate and net estate tax liability. We employ a linear programming algorithm to reweight the records to ensure that our baseline estimates of the distribution and aggregate values for gross estate and its components match the most recent published estate tax data from SOI.[xvii]

In our distribution tables, we assume the estate tax is borne by decedents, the same assumption that Treasury used in the past when it distributed the burden of estate taxes. Neither CBO nor JCT includes the estate tax in their incidence analyses.

E. Excise Taxes

Since 2015, TPC has included federal excise taxes in its distribution tables. We include all federal excise taxes, the largest of which are those assessed on motor fuels, alcohol, tobacco, air transportation, and prescription drug manufacturers. We also include the excise tax on employers that fail to meet minimum essential coverage (“employer mandate”) associated with the ACA.

We rely on CBO for our projections of baseline excise tax revenues and assume excise taxes are borne by individuals based on their incomes and relative consumption patterns.[xviii] We assume excise taxes lower real incomes in proportion to each tax unit’s share of burdened income sources. Burdened income sources include labor income, the portion of capital income that exceeds the normal rate of return, and wage-indexed cash transfer payments. In addition, we assume that excise taxes paid or passed through to the retail level change the relative prices consumers face (i.e., raise the cost of taxed goods and services relative to others). We assign this latter burden to tax units based on our consumption imputations from the CEX. The exception to this methodology is that we assume the burden of the employer mandate falls exclusively on employees of firms offering inadequate health insurance coverage.

F. Income Classifier

In 2013, TPC developed an income concept called “expanded cash income” (ECI) for the purpose of distributional analysis.[xix] We construct ECI to be a broad measure of pre-tax income, and we use it both to rank tax units in our distribution tables and to calculate effective tax rates. We define ECI to be adjusted gross income (AGI) plus:

above-the-line adjustments (e.g., IRA deductions, student loan interest, self-employed health insurance deduction, etc.);
employer-paid health insurance and other nontaxable fringe benefits;
employee and employer contributions to tax-deferred retirement savings plans;
tax-exempt interest;
nontaxable Social Security benefits;
nontaxable pension and retirement income;
accruals within defined benefit pension plans;
inside buildup within defined contribution retirement accounts;
cash and cash-like (e.g., SNAP) transfer income;
employer’s share of payroll taxes;
and imputed corporate income tax liability.
IV. Estimating Revenue, Distributional, and Incentive Effects of Tax Proposals

We use the tax model to estimate the revenue, distributional, and incentive effects of tax policy proposals. We measure the incentive effects of a policy proposal by calculating the effective marginal individual income tax rate on various forms of income.

A. Revenue Estimates

TPC incorporates several forms of behavioral responses in its revenue estimates.[xx] 

First, we assume that reported taxable income on individual tax returns responds to changes in the statutory marginal income tax rate. Based on estimates in the academic literature and JCT’s published methodology, we generally assume the elasticity of taxable income with respect to the net of tax rate (ETI) rises with income and equals 0.25 for those in the top 1/10th of one percent of the income distribution.[xxi] For proposals that expand the tax base significantly—such as proposals that repeal, or significantly limit, itemized deductions—we adjust the elasticity downward. For example, because TCJA eliminated or restricted many deductions (such as those for state and local taxes and mortgage interest), we reduce our elasticities by one-fifth so that the ETI for those at the top of the income distribution equals 0.20 for years in which TCJA is in effect.

Second, we assume that sales of capital assets respond to changes in the tax rate on capital gains. For long-term capital gains realizations, our elasticity varies with the tax rate and is approximately -0.70 at a tax rate of 20 percent. We use a higher elasticity for the first two years after a change in the capital gains rate; the short-term elasticity is approximately -1.10 at a tax rate of 20 percent. These elasticities match those described in an early publication outlining JCT estimating methodology.[xxii] Although JCT has not published the specific taxable income or capital gains elasticities that it now uses, based on published revenue estimates, TPC's behavioral assumptions appear broadly similar to those that JCT currently uses.[xxiii] 

For certain tax policy proposals, different behavioral assumptions would be a source of difference between TPC and JCT revenue estimates.

B. Distribution Estimates

Different measures depict different aspects of the distributional effects of a tax policy change. The TPC tax model, therefore, calculates several different distributional measures.

Of all the metrics we calculate and report in our standard distribution tables, we believe the most informative is the percentage change in after-tax income. A tax cut that gives everyone the same percentage increase in after-tax income leaves the relative distribution of after-tax income unchanged. A tax cut that increases after-tax income proportionately more for lower-income than for higher-income taxpayers will make the tax system more progressive (or less regressive). One that increases after-tax income more for higher-income taxpayers than for lower-income taxpayers will make the tax system less progressive (or more regressive).

Our distribution tables also show the share of the total tax change, the average size of the tax change in dollars and as a percentage of tax paid, and the average tax rate before and after incorporating the proposal.[xxiv]

Most TPC distribution tables include federal individual and corporate income taxes, payroll taxes for Social Security and Medicare, federal excise taxes, and the estate tax. TPC also has the capability to include the distributional impact of broad-based consumption taxes, such as a value-added tax. Note, however, that the distribution tables produced before June 2015 did not include excise taxes and those produced before March 2004 generally included only the individual income tax.

By convention, TPC distributes only the static impacts of tax changes. The issue of including behavioral responses to tax changes is particularly important when dealing with changes to tax rates on realized capital gains. A reduction in the marginal rate on capital gains causes increased realizations and could lead to an increase in taxes paid. But higher realizations and the consequent increase in taxes paid are voluntary and therefore do not indicate an actual increase in tax burden—investors would not have realized the gains if doing so made them worse off. Because of this, TPC distributes only the change in taxes paid on the realizations that would have occurred in the absence of the rate change.

TPC's distribution tables do allow for what tax economists refer to as "tax-form behavior." For example, TCJA repealed certain itemized deductions and increased the standard deduction. This caused some taxpayers who were itemizing under prior law to take the standard deduction instead. We include the impact of such a switch in our distributional analysis.

C. Effective Marginal Tax Rate Estimates

A taxpayer’s effective marginal tax rate (EMTR) is the percentage of an additional dollar of income that he or she would pay in tax. Individuals might alter their behavior in response to changes in their EMTR because marginal tax rates measure the additional taxes or benefits of working, saving, engaging in tax avoidance, and realizing capital gains.

A higher EMTR on wages reduces the after-tax reward for working more hours and therefore might encourage people to work less. It also raises the reward for engaging in tax avoidance, such as the restructuring of compensation packages away from taxable wages and salaries and into untaxed fringe benefits. Both the reduction in hours worked and additional tax avoidance resulting from a higher EMTR on wages would reduce taxable income and government revenues, with the potential to reduce economic output. A higher EMTR on capital gains could discourage individuals from selling assets, possibly reducing market liquidity (the “lock-in” effect) and reducing economic output if capital is allocated less efficiently.

We typically use the tax model to calculate the EMTR on wages and salaries as well as several forms of capital income (realized capital gains, interest income, and qualified dividends). We generally restrict our analysis to the effective marginal individual income tax rate.

For the tax units in the tax model database, we determine the EMTR on an income source by first calculating the tax unit’s individual income tax based on the its actual income. We then add $1,000 to the income source (for example, wages and salaries) and recalculate the tax unit’s individual income tax liability. We calculate the effective marginal tax rate to be the resulting change in tax divided by the $1,000 increase in income.

These estimates are static in the sense that we do not allow the higher wages to affect any other form of reported income or deduction. When we calculate the average effective marginal tax rate across income classes, we weight each tax unit’s EMTR by the original amount of the income source that the tax unit reported.

We continue to update the model to account for changes in tax law, new research, and the latest data.

