# Video Game Sales Analysis
A data analytics portfolio project analyzing video game sales trends across genres, platforms, release years, and platform lifecycles using SQL in BigQuery and Tableau.

## Business Task
The goal of this project is to determine which video game genres and platforms should be prioritized by a startup video game company when developing new games. This project will identify historical sales trends using video game sales data spanning from 1977 to 2020. The analysis will evaluate how video game performance across different genres and platforms has changed over time, and examine which combinations of genres and platforms have generated the most sales. The final deliverable will provide five data-driven insights to help the company identify opportunities in the video game market.

## Key Questions
* Which games, genres, and platforms demonstrate the strongest sales performance?
* How does typical game performance vary across genres and platforms?
* How has typical game performance across genres and platforms changed over time?
* Which platform and genre combinations have the strongest typical sales?
* How does sales performance change over a platform’s lifecycle?

## Data Sources
This project will use a dataset called “Video Game Sales.” created on Kaggle by Anand Shaw. The data consists of video game sales data spanning from 1977 to 2020. The data is organized by individual video games, with the following information available for each game: rank, name, platform, release year, genre, publisher, sales in North America, Europe, Japan, and the rest of the world (each in millions), and total worldwide sales. This data has a CC0: Public Domain license, was updated in the past year, and has a usability score of 10.0 on Kaggle. 

[**View the Video Game Sales Dataset →**](https://www.kaggle.com/datasets/anandshaw2001/video-game-sales)

Supplemental data consisting of release years for each platform present in the “Video Game Sales” dataset was gathered independently from reputable sources. External sources for data gathering for supplemental data and data cleaning include GameFAQs, MobyGames, VGChartz, Video Game Console Library, Nintendo, and Wikipedia.

## Data Cleaning
Data cleaning was performed in Google Sheets, with the following major cleaning decisions being made:
* Merging and Cleaning Duplicate/Regional Records
* Checking for Null Values
* Standardizing Titles
* Filling in Missing/Incorrect Values
* Removing Duplicate/Incorrect/Alternate Records
  
Full cleaning documentation can be reviewed [**here**](documentation/data_cleaning_documentation.pdf).

## Analysis and Methodology
Analysis of video game sales trends across genres, platforms, years, and platform lifecycles was performed using the cleaned video game sales dataset and supplemental platform release-year dataset in BigQuery using SQL.

Median Global Sales was used as the primary measure to reduce the influence of exceptionally high-selling games and compare typical game performance. Total Global Sales was used only when analyzing the top 10 highest-selling video games globally.

Visualizations were created in Tableau to identify sales patterns across platforms, genres, platform age, release volume, and platform-genre combinations. Sample-size thresholds were implemented where appropriate to improve the stability of median sales comparisons.

## Key Findings
1. A small number of high-performing games accounted for disproportionately high sales.
2. Platform games had the highest median global sales among genres, despite having fewer releases than several other genres.
3. Yearly median global sales in the 1980s and 1990s showed unusually high values, both in genre and platform, which coincided with a lower number of releases.
4. Typical commercial performance varied across platform-genre combinations rather than being associated with genre or platform alone.
5. Games released earlier in a platform’s lifecycle may have had stronger median sales performance, though this relationship varied by platform.

Further detail on these insights can be reviewed [**here**](reports/executive_summary.pdf).

## Limitations
1. This analysis reflects only the video game sales information represented in the dataset being used, rather than the entire video game market.
2. Some regional sales values from older or incomplete records were not carried over during cleaning, and some Year values that were missing or incorrect in the original dataset were updated using data from reputable sources. Additionally, some records were removed during the cleaning process.
3. Median Global Sales calculated from small sample sizes should be interpreted cautiously: they may be disproportionately represented among the highest median values.
4. The overall median by platform age produced a different pattern than when broken out by individual platforms, likely reflecting differences in the distribution of games across platforms and the influence of high-performing games at certain platform ages.
5. This analysis identifies associations between sales and video game genre, platform, release year, and platform age, but it does not establish causal relationships.

Further detail on these limitations can be reviewed [**here**](reports/executive_summary.pdf).

## Interactive Tableau Dashboards
Explore the interactive dashboards to examine video game sales patterns across genres, platforms, and platform lifecycles.

[**View the Interactive Tableau Dashboards →**](https://public.tableau.com/views/VideoGameSalesAnalysis_17879518593510/OverallSales_1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Project Files
| File | Description |
|---|---|
| **[Cleaned Video Game Sales Dataset](data/vg_sales_cleaned.csv)** | Final video game sales dataset cleaned in Google Sheets and used for analysis |
| **[Platform Release Years Dataset](data/vg_platform_release_years.csv)** | Supplemental platform release-year data used for lifecycle analysis |
| **[Removed Entries](data/vg_sales_removed_entries.csv)** | Documentation of records removed during the cleaning process and reasons for removal |
| **[Data Cleaning Methodology](documentation/data_cleaning_documentation.pdf)** | Detailed documentation of the data cleaning process and decisions |
| **[SQL Analysis](sql/vg_sql_analysis.sql)** | SQL queries used to perform the analysis in BigQuery |
| **[Executive Summary](reports/executive_summary.pdf)** | Detailed analysis insights and limitations |
