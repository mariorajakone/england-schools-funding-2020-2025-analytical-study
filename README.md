# UK Schools Allocation Funding 2020-2025

## Background Overview
The School funding allocations are official statistics published to GOV.UK on an annual basis. It contains the funding received by individual mainstream schools in England (approx. 20,000) which are broken down into it’s different local authorities.
There are numerous fields in the data due to all the elements that the total funding consists of, both through their core budgets and through several other revenue grants for the academic years from 2020-21 to 2024-25 e.g. basic entitlement for the years groups, deprivation band and free school meals.
Insights and recommendations are provided on the following key areas.

- Yearly Funding Analysis : How has funding changed since 2021?
- Regional Spread : Is funding shared equally across the country?
- How does funding per pupil vary by region/LA?
- Which regions face the highest cost pressures per pupil?
- Comparision against inflation : Is school funding keeping pace with inflation?

An interactive Tableau dashboard can be downloaded here.

The SQL queries used to inspect and perform quality check can be found here

The SQL Queries used to clean and prepare the data for the dashboard can be found here.

The SQL Queries used to compare the validity of the dashboard values can be found here.

## Overview of Findings

Since 2020, England Schools have seen a steady increase in total funding, with £2.4bn being added each year on average (more so from 2023). However, when put into context and compared against inflation, it has given mixed results but looks to becoming more aligned coming into 2025.

Average increase in allocation from £4707 in 2021 to £5752. As of 2025, this is beating inflation by approximately 1%.

When broken down by school type, Primary schools, are getting larger share of the funding but the YoY funding to Secondary schools rises at a large rate compare to Primary schools, and is comfortably above inflation in the last 3-4 years.

In 2022, even though the funding had increased by £1.4bn, there was a drastic gap due to huge rise in inflation that year (due to surging food & energy prices following the pandemic + war in Ukraine).

Each year the top 15 schools based on their average Allocation per Pupil area were all based in London.

The funding was spread relatively evenly across the UK, however the most northern LAs seemed to have an allocation of £300-400 extra than the rest of the UK (excluding London).

The Average Allocation per Pupil across the whole of the UK, increased Year-on-Year at a rate of £200-300.

## Recommendations:
There are several directions that can be taken from here
- Delve deeper into the different areas that make up the total funding. There are over 20 different criteria that add up to what is Total Funding. I would see what is relevant and which fields are make neglible difference and see what areas are affected by the main drivers.
- Look closely at joining other data sources. The first one to think about would be region deprivation. Are some areas/schools that are classed as low deprivation receiving lower allocation.
- The second one is seeing if there is a relationship between funding increase/decrease and academic outcome. Where does the school rank according to the latest OFSTED results.
- Is it possible to make a definite model that has a high chance of improving a school’s outcome? If so, that will give a better idea of which Las/schools to target.
- You don’t much by have all the answers on one dashboard, this would require a few dashboards to visualise the findings clearly.
