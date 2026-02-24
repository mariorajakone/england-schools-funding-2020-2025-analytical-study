# Data Cleaning actioned in Excel and SQL #

**What do we want to get out of the data cleaning process?**<br>
We want there to be minimal disruption to the data as possible and the key metrics do not have missing values which could skew the average allocation for that year or the Local Authority. We do not want any duplicated schools, and for the format of the fields and metrics in each annual file to be consistent. It will need to be done in a way that should anything happen to the source data, that refreshing or re-uploading the data is a simple and smooth process.

## Steps:
1. Downloaded 5 csv files into folder from [GOV.UK](https://explore-education-statistics.service.gov.uk/find-statistics/school-funding-statistics/2024-25), then one-by-one I imported them into SQL Server. As there were quite a few columns, it was easier to use the SSMS Import tool to do that process.

2. In the original files, I created copies so I could do some quality checks on them. The checks included MAX Length, MIN Length, Negative Values, Non-Numeric columns, Blank Rows and Floats. I also did this so that when I set the size of the fields, the records will not be truncated.

<img width="1803" height="595" alt="image" src="https://github.com/user-attachments/assets/13437190-f653-47ba-9a55-2ae93b57343d" />

3. Some of the columns were too long, so the import tool automatically suggested the columns names for those. Doubled checked these to make sure they made sense.

4. The import tool also suggested the data types to set each column to. Some data types were incorrect so those were changed. This could be an integer being set to money / string / float e.g. in the case of the School URN where it makes sense for it to be set as an integer, it's preferable to be set to a string/varchar as it is a unique identifier rather than a measure. In addition, the numeric fields which has non-numeric in them had to be set to Allow NULLs.

<img width="495" height="452" alt="image" src="https://github.com/user-attachments/assets/93bfbac2-6b7a-4158-9632-dbd7b30aa5ac" />

5. The import tool returned warnings that some fields may contain NULLS and the data will be missing/truncated due to mismatch in data types. I made a note of these fields so I could check these later for data completion.

6. When the data had been loaded, I did a rowcount and compared that to the original file row count, aswell as a distinct count of the School URNs to make sure they matched.

7. Using the list of fields that may contain NULLs, I queried the table for the NULLs and cross checked that will the original source files.

8. Once I was happy with the data quality in each table, I created a view to combine all 5 tables into one. This then created the basis of the extract to be loaded into Tableau. I checked for duplicate Local Authorities and School Phases- SQL scripts can be found [here](https://github.com/mariorajakone/uk-school-funding/blob/main/School%20Funding%20SQL%20Queries.sql). I decided to handle these within Tableau.

## Issues that needed to be resolved:

- Integer/Floats fields containing 'Not Available', '*', 'z', 'x'. Happy for these to be converted to NULL values as they didn't impact the main funding fields required for this project.
- Some parts of the source were formatted differently and so returned NULLs when imported so had to set it all to the same format
- When the import tool was converting a decimal number/float into an integer field, it set the values to NULL when the decimal value wasn't detected prior
- There were a handful of Local Authorities that had slight changes in it's full name across a few of the years. It was important that these needed to be grouped together to avoid inaccurate averages when doing regional analysis
- 1 row had a negative value
- 1 row had DIV/0 which is most likely the result of copying a calculation where trying to divide by 0 calculation
- 1 column had issues with it's data properties, so it just needed a re-insert seemed to solve that

## Loading files directly into Tableau

Another consideration was to load the individual files directly into Tableau and Union the generated tables together. The problem with doing it this way was 

- When a following academic year has different column headers (even slightly) then Tableau does not recognise it as the same field and so creates a new column
- If you then try to use the Merge Mismatched Fields function, the processing performance decreases with every merge, especially with larger datasets
- SQL and Excel performed faster and more efficient to do EDA with this dataset when trying to spot anomolies

Using Unions and Merge Mismatched Fields are useful functions to know, but I would only recommend them for smaller simpler datasets. For mid-high detailed levels of data, I would suggest doing the data wrangling and manipulation in Excel and/or SQL first.
