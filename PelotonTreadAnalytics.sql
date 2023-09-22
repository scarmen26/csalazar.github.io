-- Project: Peloton Tread Workout Analysis

-- Project Description: 

/*In this project, I clean, manipulate, and prepare this dataset for analysis by identifying and removing duplicate records, handling missing values, correct errors, convert data types,
standardize formats, create derived features, identify and handle outliers if needed. I aim to uncover trends, patterns, and performance metrics from the collected workout data.
The analysis will provide valuable insights into my personal fitness progress, perferred workout styles,overall performance, and potntial improvement.

I aim to answer questions like the ones below:

1) How often do i work out on overage? Are there specific days or times when i am more likely to exercise? (Workout frequency)
2) What is the average duration of my workouts? How do they vary across different workout/exercise categories? (Workout duration)
3) How does the intensity of my workouts vary over time? Am i increasing or decreasing the intensity of my exercises? (Exercise intensity)
4) How is my performance improving or changing over time? Am i achieving better results in terms of of distance covered, calories burned, or ouput metrics? (Performance trends)
5) What are the most common types of workouts you engage in (e.g., running, strength training)? Which workouts am i doing the most frequently? (Workout types)
6) Have i achieved any significant milestones, such as reaching a specific distance, achieving a personal best, or completing a challenge? (Achievement milestones)
7) Is there any patterns in the timing of the workouts, such as exercising more on weekdays or weekends, morning or evenings? (Workout timing)
8) Am i varying my workouts to include different exercise types and intensities, or do i tend to stick to a specific routine? (Workout variability)
9) Are there any external factors like weather, time of year, or personal events that impact my workout patterns? (Impact of external factors)

By anwering questions like the above and conducting various analysis on my Peloton workout data, i can gain a better understanding of my fitness journey, identify areas for improvement, and track
my progress over time. These insights can help me set new fitness goals, adjust my current exercise routine, and stay motivated to achieve my desired fitness goals.*/

-- The datasat, originally in Excel worksheet format, contains 18 columns total, and 804 rows of data


----------------------------------------------------------------- Determining the total number of columns in the table 'tread_workouts' -------------------------------------------------------

SELECT COUNT(*) AS TotalColumn-- selects the count of all rows using COUNT(*), gives the result an alias of 'TotalColumn'
FROM INFORMATION_SCHEMA.COLUMNS -- specifies the source of data for the query. Query is retrieving info from the INFORMATION_SCHEMA.COLUMNS view
WHERE TABLE_NAME = 'tread_workouts'; -- this condition filters the results to only include info about columns in the table named 'tread_workouts'


----------------------------------------------------------------- Determining column names in the table 'tread_workouts' -------------------------------------------------------

SELECT COLUMN_NAME -- retrieve values in the 'column_name' column
FROM INFORMATION_SCHEMA.COLUMNS -- from source of data, which is the INFORMATION_SCHEMA.COLUMNS system view (a column that contains names of all columns in the database)
WHERE TABLE_NAME = 'tread_workouts'; -- condition that filters the result to only include info about columns in the table 'tread_workouts'


----------------------------------------------------------------- Determining the total number of rows in the table 'tread_workouts' --------------------------------------------------
-- Counting rows in the table, based on the values in the 'Workout_Timestamp' column

SELECT COUNT(Workout_Timestamp) AS TotalRows -- retrieve count of non-null values in the 'Workout_Timestamp' column, give the result an alias of 'TotalRows'
FROM tread_workouts; -- from the source of data, 'tread_workouts' table


-- Dealing with NULL Values
-- Using 'IS NULL' condition to retrieve null values from specific columns in the dataset




-- There are 4 NULL values in the column Live_On_Demand

SELECT Live_On_Demand -- retrieve values in the 'Live_On_Demand' column
FROM dbo.tread_workouts -- from data source, table 'tread_workouts'
WHERE Live_On_Demand IS NULL -- condition that filters the results to only include rows where the value in the 'Live_On_Demand' column is NULL.

-- Updating 4 NULL cells in the 'Live_On_Demand' column in the tread_workouts table, and setting the value to 'On Demand', but only for rows where the 'Live_On_Demand' column is NULL.
-- NULL values were set to 'On Demand' because these classes were not live sessions when i took them, they were pre-recorded content

UPDATE dbo.tread_workouts -- update the 'dbo.tread_workouts' table
SET Live_On_Demand ='On Demand' -- specifies column i want to update, and value i want to assign to the column
WHERE Live_On_Demand IS NULL; -- filter to only include rows where value in 'Live_On_Demand" column is NULL


-- Selecting 'Instructor_Name' column from the 'tread_workouts' table where the instructor name is missing or NULL.
--This will return a list of rows where the 'Instructor_Name' column has no value. After runnung the query, i see there are 27 null values.

SELECT Instructor_Name -- rectrieve column 'Instructor_Name'
FROM dbo.tread_workouts -- from table 'tread_workouts'
WHERE Instructor_Name IS NULL -- filter results to only show rows where the value in the 'Instructor_Name' column is NULL

-- Updating 27 NULL cells in the 'Instructor_Name' column in the tread_workouts table, and setting the value to 'No instructor' where the instructor name is NULL.
/*There was no instructor for these classes because they were either Scenic Runs or 'Just Run's. Scenic runs are virtual augmented reality experiences that simulate outdoor running in various picturesque
locations around the world.'Just Run's were unguided classes with no music, or virtual environments.*/

UPDATE dbo.tread_workouts -- update table 'dbo.tread_workouts'
SET Instructor_Name = 'No Instructor' -- assign 'Instructor_Name' column, the value of 'No Instructor'
WHERE Instructor_Name IS NULL; -- where rows in the column 'Instructor_Name' are NULL

-- retrieiving total number of NULLS within the column 'Type'. There are 4 total
SELECT Type -- retrieve column 'Type'
FROM tread_workouts -- from table 'tread_workouts'
WHERE Type IS NULL -- filter the results to only show rows where the value in the 'Type' column is NULL

-- Updating 4 cells in the 'Type' column in the tread_workout table, and setting the value to 'Warm Up/Cool Down' where the type of class is NULL
/*These 4 classes were Just Runs, they varied between 4 minutes-7 minutes, and were used as warm ups/cool downs.*/

UPDATE dbo.tread_workouts -- update the table 'tread_workouts'
SET Type = 'Warm Up/Cool Down' -- assign the 'Type' column the value of 'Warm Up/Cool Down'
WHERE Type IS NULL; -- for only the the rows where the value in the 'Type' column is NULL


------------------ Handling NULL Values for the Fitness Discipline of Stretching and Strength --------------------------------------

/* NULL values within the rows of columns of Total Output, Avg. Speed (mph), Distance (mi), Avg. Incline, and Avg. Pace (min/mi) were set to 'N/A' becuase there is 
no applicable data for these particular cells. This data is missing because the fitness metrics for these workouts were not generated. Stretching and strength 
workouts do not generate workout metrics like cardio workouts where metrics like speed, distance, and power output are more applicable. Stretching and strength workouts
are usually slow, controlled movements, flxibility exercises, and resistance training that do not involve being on the treadmill itself. Sensors and technology that are
designed to measure and track specific metrics like speed, incline, and power output during cardio-focused workouts are not activated or relevant during stretching and 
strength routines.

Using N/A helps convey that these specific data points are not available or do not apply to the context, which is useful for data integrity and analysis - 
used to maintain consistency and clarity in records where fields dont have data*/


-- Updating 17 cells in the 'Total_Output' column, in the tread_workout table, and setting the value to 'N/A' where the total output is NULL
SELECT Total_Output -- retrieve column 'Total_Output'
FROM tread_workouts -- from the 'tread_workouts' table
WHERE Total_Output IS NULL; -- filter the results to only show rows where the value in the 'Total_Output' column is NULL

-- Updating 17 cells in the 'Total_Output' column, in the tread_workout table, and setting the value to 'N/A' where the total output is NULL
UPDATE dbo.tread_workouts
SET Total_Output = 'N/A'
WHERE Total_Output IS NULL;

/* when running the above, i encounter the error message of "Conversion failed when converting the varchar value 'N/A' to data type smallint." 
This indicates that there was an issue with trying to convert a character string ('N/A') into a numeric data type (smallint). The system expects
the data types to match appropriately. I attempted to insert/perform an operation that requires a numeric value (smallint), but provided a
character string ('N/A') instead, which was not able to be directly converted into a numeric type.

I want to replace the NULL values in the 'Total_Output' column with the string 'N/A', so i altered the data type of the column (currently defined as a numeric data type, such as SMALLINT),
to a column to a string data type (VARCHAR) so that i can store 'N/A'.*/

ALTER TABLE dbo.tread_workouts
ALTER COLUMN Total_Output VARCHAR(10);

-- After changing the data type to VARCHAR, i then run the UPDATE statement to set the NULL values to 'N/A'
UPDATE dbo.tread_workouts -- update table 'tread_workouts'
SET Total_Output = 'N/A' -- assign to the column of 'Total_Output', the value of 'N/A'
WHERE Total_Output IS NULL; -- filter the results to only show rows where the value in column 'Total_Output' is NULL


-- retrieiving total number of NULLS within the column 'Avg_Speed_mph'. There are 17 total

SELECT Avg_Speed_mph -- retrieve 'Avg_Speed_mph' column
FROM tread_workouts -- from the source table of 'tread_workouts'
WHERE Avg_Speed_mph IS NULL; -- filter the results to only include rows within column 'Avg_Speed_mph', where the value is NULL 

-- Converting data type of column 'Avg_Speed_mph' (float), into varchar
-- Modifying the structure of a database table named 'tread_workouts' in the 'dbo' schema. Specifically, it is altering the data type of a column named 'Avg_speed_mph' to be of type VARCHAR(10)
-- this query changes the data type of the 'avg_speed_mph' column from its current data type to a VARCHAR data type with a maximum length of 10 characters.

ALTER TABLE dbo.tread_workouts 
ALTER COLUMN Avg_Speed_mph VARCHAR(10); 

/* ALTER TABLE dbo.tread_workouts: this part of the query specifies that you want to make changes to the table named 'tread_workouts' in the'dbo' schema. It identifies the table you want to modify.
ALTER COLUMN: this command is used to change the properties of a specific column within the table
Avg_speed_mph: this is the name of the column within the 'tread_workouts' table you want to modify
VARCHAR(10): this part specifies the new data type for the
Avg_speed_mph column. In this case, its changing the data type to a variable-length character string (VARCHAR) with a maximum length of 10 characters.*/


-- Updating 17 cells in the 'Avg_Speed_mph' column, in the tread_workout table, and setting the value to 'N/A' where the total output is NULL
UPDATE dbo.tread_workouts -- update table 'tread_workouts'
SET Avg_Speed_mph = 'N/A' -- assign to the column of 'Avg_Speed_mph', the value of 'N/A'
WHERE Avg_Speed_mph IS NULL; -- where the rows within the column 'Avg_Speed_mph', where the value is NULL


-- retrieving total number of NULLS within the column 'Distance_mi'. There are 17 rows total

SELECT Distance_mi -- retrieve column 'Distance_mi'
FROM tread_workouts -- from the source table 'tread_workouts'
WHERE Distance_mi IS NULL; -- filter the results to include rows within the column of 'Distance_mi'

-- converting data type of 'Distance_mi' (float) into varchar
ALTER TABLE dbo.tread_workouts -- modify the 'tread_workouts' table
ALTER COLUMN Distance_mi VARCHAR(10); -- ALTER COLUMN command is used to change the data type of a column. Changes data type of column named 'Distance_mi' in the 'tread_workouts' table to type that stores variable-length strings of charcters. with a string length of 10

-- Updating 17 row cells in the 'Distance_mi' column, within the 'tread_workout' table, and setting the value to 'N/A' where the distance_mi is NULL
UPDATE dbo.tread_workouts
SET Distance_mi = 'N/A'
WHERE Distance_mi IS NULL;

-- retrieve total number of cells within the rows of column 'Avg_Incline' that have the value of NULL. There are 323 row cells total

/* There is a total of 323 NULL values in the 'avg_incline' column for the fitness disciplines of walking (306), stretching (16), and strength (1) because 
these activites do not typically involve incline changes on a treadmill, so therefore the system does not generate incline values for them*/

SELECT Avg_Incline -- retrieve the column named "avg_incline"
FROM tread_workouts -- from the datasource/table named "tread_workouts"
WHERE Avg_Incline IS NULL; -- filters the results to include only the rows within the column of "avg_include" that have the value of "NULL"

-- converting datatype of column 'avg_incline' (float) into varchar

ALTER TABLE dbo.tread_workouts -- modify the table 'tread_workouts'
ALTER COLUMN Avg_Incline VARCHAR(10); -- modify/change the data type of column 'Avg_incline' in the 'tread_workouts' table to data type that stores variable length strings of characters. with a string length of 10 

-- updating 323 row cells in the 'Avg_incline' column, within the 'tead_workouts' table, and setting the value to 'N/A' where the avg_incline is NULL

UPDATE dbo.tread_workouts
SET Avg_Incline = 'N/A'
WHERE Avg_Incline IS NULL;

-- retrieve total number of cells within the rows of column 'Avg_Pace_min_mi' that have the value of NULL. There are 331 row cells total
SELECT Avg_Pace_min_mi
FROM tread_workouts
WHERE Avg_Pace_min_mi IS NULL;

-- updating 331 row cells in the 'Avg_Pace_min_mi' within the 'tread_workouts' table, and setting the value to 'N/A' where the avg_pace_min_mi is NULL
 UPDATE dbo.tread_workouts
 SET Avg_Pace_min_mi = 'N/A'
 WHERE Avg_Pace_min_mi IS NULL;



 ------------------------------------------------------------ Deleting unused columns from database table ----------------------------------------------------------------
/*Deleting columns:  Avg. Watts, Avg. Resistance, Avg. Cadence (RPM), and Avg. Heartrate because there is no data within them, this implies that the columns will not be used
nor are relevant to the current database schema. Deleting columns with no data can 1) simplyfiy the database schema, making it more understandable and maintable [simplifying the schema],
2) contribute to the overall storage overhead of the table (although empty columns consume very little storage space, if you have alot of them, the cumulative effect can be significant),
3) reduce potential risk of accidentally populating or modifying data in those columns [enhancing data integrity], 4) improve query performance (even though empty cells dont contain data, they
can still be part of query plans and consume processing resources during query execution), 5) can make schema more reflective of the actual data model, aiding in documentation and understanding.*/

ALTER TABLE dbo.tread_workouts
DROP COLUMN Avg_Watts,
DROP COLUMN Avg_Resistance,
DROP COLUMN Avg_Cadence_RPM,
DROP COLUMN Avg_Heartrate;

/* got the following errors: 
Msg 156, Level 15, State 1, Line 224
Incorrect syntax near the keyword 'DROP'.
Msg 102, Level 15, State 1, Line 224
Incorrect syntax near 'Avg_Resistance'.
Msg 102, Level 15, State 1, Line 225
Incorrect syntax near 'Avg_Cadence_RPM'.
Msg 102, Level 15, State 1, Line 226
Incorrect syntax near 'Avg_Heartrate'. */


----------------------------------------------------------- Date and Time Manipulation --------------------------------------------------------------------------------------

/* current date format: "2020-09-29 15:45 (PDT)". This format includes the following components: 
- year (2020)
- month (9)
- day (29)
- time (hour and minute): 15:45
- time zone abbreviation (PDT - Pacific Daylight Time)

----------------------------------------------------------- Date and time in a standardized SQL-compatible format

This format is not a standard date and time representation used in SQL. It appears to be a format that includes the date and time along with the time zone abbreviation for Pacific Daylight Time.
To be able to work with this data in SQL, i need to convert it to a standard date and time format such as "yyyy-mm-dd hh:mi:ss", where
- yyyy represents the year (2020)
- mm represents the month (9)
- dd represents the day (29)
- hh represents the house in 24-hour format (e.g., 15 for 3PM)
- mi represents the minute (e.g., 45)
- ss represents the second (assumed to be 00 as the original format did not include seconds)*/


-- Transforming date and time format "2020-09-29 15:45 (PDT)" into a standardized SQL-compatible format ("yyyy-mm-dd hh:mi:ss")
CONVERT(