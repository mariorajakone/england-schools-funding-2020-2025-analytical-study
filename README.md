# UK Schools Allocation Funding Analysis 2020-2025

## Background Overview
The School funding allocations are official statistics published to GOV.UK on an annual basis. It contains the funding received by individual mainstream schools in England (approx. 20,000) which are broken down into it’s different local authorities.
There are numerous fields in the data due to all the elements that the total funding consists of, both through their core budgets and through several other revenue grants for the academic years e.g. deprivation band, free school meals and basic entitlement for the various years groups.
Insights and recommendations are provided on the following key areas.

- Yearly Funding Analysis : How has funding changed since 2021?
- Regional Spread : Is funding shared equally across the country?
- How does funding per pupil vary by region/LA?
- Which regions face the highest cost pressures per pupil?
- Comparision against inflation : Is school funding keeping pace with inflation?

An interactive Tableau dashboard can be downloaded [here](https://public.tableau.com/app/profile/mario.rajakone/viz/UKSchoolsFundingAllocations2020-2025/SchoolFundingSystem?publish=yes).

The SQL queries used to inspect and perform quality check can be found here

The SQL Queries used to clean and prepare the data for the dashboard can be found here.

The SQL Queries used to compare the validity of the dashboard values can be found [here](https://github.com/mariorajakone/uk-school-funding/blob/main/Funding%20SQL%20Queries).

## Data Structure & Initial Checks

The Government School Funding Allocation data consists of one csv dataset per academic year. I uploaded the data into a SQL Server database, with one table per academic year. Each year consisted of between 20,150 to 20,200 rows each representing a different school with it's main fields of URN, provider_type and Local Authority. Along with this are the key metrics Total Funding, Allocation per Pupil and Total Number of Pupils. Here is a simplified diagram of the Funding table, which shows it relationship to the Inflation based on the Time Period (Academic Year).

<img width="531" height="472" alt="image" src="https://github.com/user-attachments/assets/1b6e97f7-4431-48ca-92f8-c3b85bd306b8" />

Prior to beginning the analysis, a variety of checks were carried out to determine the datatype, size and length of the fields for quality control purpose and familiarise myself with the dataset. The SQL queries used to perform these checks can be found here.

## Overview of Findings

Since 2020, England Schools have seen a steady increase in total funding, with £2.4bn being added each year on average (and even more from 2023). However, when put into context and compared against inflation, it has given mixed results where it has fluctuated before settling down and becoming more aligned coming into 2025.

<img width="1597" height="897" alt="image" src="https://github.com/user-attachments/assets/7deccfd3-247b-4fb2-a45d-947e178ab61d" />


The average increase in allocation rose from £4472 in 2021 to £5462 in 2025, which was beating inflation by approximately 1%.

In 2022, even though the funding had increased by £1.4bn, there was a large gap due to huge rise in inflation that year (due to surging food & energy prices following the pandemic + war in Ukraine).

The Average Allocation per Pupil across the whole of the UK, increased Year-on-Year at a rate of £200-300.

Looking at regional spread, 17 of the top 20 highest LAs were in London (based on average allocated per Pupil). If these were taken aside, the funding was spread relatively evenly across the country (within the £5-6k bracket). However the most northern LAs seemed to have an allocation of £300-400 extra than the rest of the UK (again excluding London).

When broken down by school type, Primary schools are getting the larger share of the funding, but the YoY funding to Secondary schools rises at a bigger rate in comparison, and they are comfortably above inflation over the last 3-4 years.

<img width="372" height="435" alt="image" src="https://github.com/user-attachments/assets/9215686a-90d5-4e94-a6a4-f8e9f3335ddb" />

Taking a deeper look at Secondary schools, in 2025 Central Bedfordshire stands out as the only Local Authority sub £5k per pupil.

## Recommendations:
There are a couple directions that can be taken from here

- Talk to Department for Education Funding team about Central Bedfordshire Local Authority. Are they aware that they are the lowest funded LA for secondary schools and is there a reason for it?
Should they be getting more and is this being rectified in the forthcoming allocations for 2026 so they are in align with the rest of the country.
When you compare this to Knowsley who are at the other end of the scale who receive £3334 per pupil more. The number of schools and pupils at each is taken into consideraion but there doesn't seem to be a clear correlation so far as to why this funding gap.

- On a similar note, whichever way you visualise the data, the northern most LAs have consistently received the most funding compared to it's southern counterparts. This is  something that would require another dashboard to outline detailed findings clearer, and would mostly be highlighted in a regional social deprivation analysis.

## Next Steps:

- Delve deeper into the different areas that make up the total funding. There are over 20 different criteria that add up to what consists Total Funding. I would see what is relevant and which fields are the main drivers and which make neglible difference.
- Look closely at joining other data sources, primarily would be region deprivation. Are some areas/schools that are classed as low deprivation receiving lower or higher allocation?
- The next data source would be academic outcome and again see if there is a relationship between funding increase/decrease. Where do schools with lower funding rank according to the latest OFSTED results?
- Is it possible to make a definite model that has a high chance of improving a school’s outcome? If so, that will givea better idea of which LAs/schools to target more funding towards.
