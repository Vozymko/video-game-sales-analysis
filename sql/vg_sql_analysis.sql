--Median Global Sales by Genre
SELECT DISTINCT 
  Genre,
  PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Genre) AS Median_Global_Sales
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
ORDER BY 
  Median_Global_Sales DESC



--Median Global Sales by Platform
SELECT DISTINCT 
  Platform,
  PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Platform) AS Median_Global_Sales
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
ORDER BY 
  Median_Global_Sales DESC



--Genre Release Volume
SELECT DISTINCT 
  Genre,
  COUNT(*) AS Game_Count
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
GROUP BY
  Genre



--Platform Release Volume
SELECT DISTINCT 
  Platform,
  COUNT(*) AS Game_Count
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
GROUP BY
  Platform



--Yearly Median Global Sales by Genre
WITH median_gs_by_genre AS (
  SELECT DISTINCT
    Year,
    Genre,
    PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Year, Genre) AS Median_Global_Sales
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
),
years AS (
  SELECT DISTINCT
    Year
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` 
),
genres AS (
  SELECT DISTINCT
    Genre
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
),
year_genre_grid AS (
  SELECT
    years.Year,
    genres.Genre
  FROM years
  CROSS JOIN genres
)
SELECT
  grid.Year,
  grid.Genre,
  COALESCE(median.Median_Global_Sales, 0) AS Median_Global_Sales
FROM year_genre_grid AS grid
LEFT JOIN median_gs_by_genre AS median
  ON grid.Year = median.Year
  AND grid.Genre = median.Genre
ORDER BY 
  grid.Year ASC,
  grid.Genre ASC



--Yearly Median Global Sales by Platform
WITH median_gs_by_platform AS (
  SELECT DISTINCT
    Year,
    Platform,
    PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Year, Platform) AS Median_Global_Sales
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
),
years AS (
  SELECT DISTINCT
    Year
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` 
),
platforms AS (
  SELECT DISTINCT
    Platform
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
),
year_platform_grid AS (
  SELECT
    years.Year,
    platforms.Platform
  FROM years
  CROSS JOIN platforms
)
SELECT
  grid.Year,
  grid.Platform,
  COALESCE(median.Median_Global_Sales, 0) AS Median_Global_Sales
FROM year_platform_grid AS grid
LEFT JOIN median_gs_by_platform AS median
  ON grid.Year = median.Year
  AND grid.Platform = median.Platform
ORDER BY 
  grid.Year ASC,
  grid.Platform ASC



--Yearly Games Released by Genre
WITH years AS (
  SELECT DISTINCT
    Year
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` 
),
genres AS (
  SELECT DISTINCT
    Genre
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
),
game_counts AS (
  SELECT
    Year,
    Genre,
    COUNT(*) AS num_games
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
  GROUP BY
    Year,
    Genre
)
SELECT
  years.Year,
  genres.Genre,
  COALESCE(game_counts.num_games, 0) AS Game_Count
FROM years
CROSS JOIN genres
LEFT JOIN game_counts
  ON years.Year = game_counts.Year
  AND genres.genre = game_counts.Genre
ORDER BY
  years.Year ASC,
  genres.Genre ASC



--Yearly Games Released by Platform
WITH years AS (
  SELECT DISTINCT
    Year
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` 
),
platforms AS (
  SELECT DISTINCT
    Platform
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
),
game_counts AS (
  SELECT
    Year,
    Platform,
    COUNT(*) AS num_games
  FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
  GROUP BY
    Year,
    Platform
)
SELECT
  years.Year,
  platforms.Platform,
  COALESCE(game_counts.num_games, 0) AS Game_Count
FROM years
CROSS JOIN platforms
LEFT JOIN game_counts
  ON years.Year = game_counts.Year
  AND platforms.Platform = game_counts.Platform
ORDER BY
  years.Year ASC,
  platforms.Platform ASC



--Median Global Sales by Platform and Genre Combinations
SELECT DISTINCT
  Platform, 
  Genre,
  PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Platform, Genre) AS Median_Global_Sales,
  COUNT(*) OVER (PARTITION BY Platform_Age) AS Game_Count
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
ORDER BY 
  Median_Global_Sales DESC



--Overall Median Global Sales and Game Count by Platform Age at Game Release
WITH vg_sales_with_release_year AS(
SELECT 
  vg_sales.Name,
  vg_sales.Platform,
  vg_sales.Year,
  release_years.`Release Year` AS Release_Year,
  vg_sales.Year - release_years.`Release Year` AS Platform_Age,
  vg_sales.Global_Sales
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` AS vg_sales
JOIN `theta-actor-504716-g3.vg_sales.platform_release_years` AS release_years 
  ON vg_sales.Platform = release_years.Platform
)
SELECT DISTINCT
  Platform_Age,
  PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Platform_Age) AS Median_Global_Sales,
  COUNT(*) OVER (PARTITION BY Platform_Age) AS Game_Count
FROM vg_sales_with_release_year
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY Platform_Age
) = 1
ORDER BY 
  Platform_Age



--Median Global Sales and Game Count by Platform Age at Game Release - Broken Down by Platform
WITH vg_sales_with_release_year AS(
SELECT 
  vg_sales.Name,
  vg_sales.Platform,
  vg_sales.Year,
  release_years.`Release Year` AS Release_Year,
  vg_sales.Year - release_years.`Release Year` AS Platform_Age,
  vg_sales.Global_Sales
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` AS vg_sales
JOIN `theta-actor-504716-g3.vg_sales.platform_release_years` AS release_years 
  ON vg_sales.Platform = release_years.Platform
)
SELECT
  Platform_Age,
  Platform,
  PERCENTILE_CONT(Global_Sales, 0.5) OVER(PARTITION BY Platform_Age, Platform) AS Median_Global_Sales,
  COUNT(*) OVER (PARTITION BY Platform_Age, Platform) AS Game_Count
FROM vg_sales_with_release_year
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY Platform_Age, Platform
    ORDER BY Name
) = 1
ORDER BY 
  Platform_Age, 
  Platform



--Platform Release Timeline - Platform Release Year to Last-Released Game in Dataset
SELECT 
  vg_sales.Platform,
  release_years.`Release Year` AS Release_Year,
  MAX(vg_sales.Year) AS Last_Game_Year
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned` AS vg_sales
JOIN `theta-actor-504716-g3.vg_sales.platform_release_years` AS release_years 
  ON vg_sales.Platform = release_years.Platform
GROUP BY 
  vg_sales.Platform, 
  Release_Year



--Top 10 Games by Global Sales
SELECT 
  *
FROM `theta-actor-504716-g3.vg_sales.vg_sales_cleaned`
ORDER BY
  Global_Sales DESC
LIMIT 10
