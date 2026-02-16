# UK Schools Allocation Funding 2020-2025

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

The SQL Queries used to compare the validity of the dashboard values can be found here.

## Overview of Findings

Since 2020, England Schools have seen a steady increase in total funding, with £2.4bn being added each year on average (and even more from 2023). However, when put into context and compared against inflation, it has given mixed results where it has fluctuated before settling and becoming more aligned coming into 2025.

<img width="1597" height="897" alt="image" src="https://github.com/user-attachments/assets/7deccfd3-247b-4fb2-a45d-947e178ab61d" />


Average increase in allocation from £4472 in 2021 to £5462 laat year. And as of 2025, this is beating inflation by approximately 1%.

In 2022, even though the funding had increased by £1.4bn, there was a large gap due to huge rise in inflation that year (due to surging food & energy prices following the pandemic + war in Ukraine).

When broken down by school type, Primary schools, are getting larger share of the funding, but the YoY funding to Secondary schools rises at a large rate compare to Primary schools, and is comfortably above inflation over the last 3-4 years.

Looking at regional spread, 17 of the top 20 highest LAs were in London (based on average allocated per Pupil). If these were taken aside, the funding was spread relatively evenly across the country (within the £5-6k bracket). However the most northern LAs seemed to have an allocation of £300-400 extra than the rest of the UK (excluding London).

The Average Allocation per Pupil across the whole of the UK, increased Year-on-Year at a rate of £200-300.

Taking a deeper look at Secondary schools, Central Bedfordshire stands out as the only Local Authority sub £5k per pupil.

<img width="372" height="435" alt="image" src="https://github.com/user-attachments/assets/9215686a-90d5-4e94-a6a4-f8e9f3335ddb" />

## Recommendations:
There are several directions that can be taken from here

- Talk to Department for Education Funding team about Central Bedfordshire Local Authority. Are they aware that they are the lowest funded LA for secondary schools and is there a reason for it. Can they apply to get more so they are in align with the rest of the country. When you compare this to Knowsley who are at the other end of the scale, and when you compared the number of schools and pupils at each, there isn't a definite correlation so far as to why Knowsley would receive £3334 per pupil more.

- On a similar vain, which ever you look at it, the northern most LAs have consistently received the most funding compared to it's southern counterparts. This is not something that would require another dashboard to visualise detailed findings clearer. This is something that would mostly be highlighted in a regional social deprivation analysis.

## Next Steps:
- Delve deeper into the different areas that make up the total funding. There are over 20 different criteria that add up to what is Total Funding. I would see what is relevant and which fields are make neglible difference and see what areas are affected by the main drivers.
- Look closely at joining other data sources. The first one to think about would be region deprivation. Are some areas/schools that are classed as low deprivation receiving lower allocation.
- The second one is seeing if there is a relationship between funding increase/decrease and academic outcome. Where does the school rank according to the latest OFSTED results.
- Is it possible to make a definite model that has a high chance of improving a school’s outcome? If so, that will give a better idea of which Las/schools to target.
