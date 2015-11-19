# Cook Book

## Read activity data

1. Read Activity Labels and store it in acvitivityLbls
2. Read Test activity data and mutate the integer value to the corresponding activity label stored in activityLbls and store the table in testActivity
3. Repeat above for train activity and store it in trainActivity
4. Remove the activityLbls as we no longer require

## Read Column names for data
1. Read the column names for the data from features.txt and store it in features
   Drop the first column as it is not useful.

### Fix duplicate column names
   Fix duplicate column names
   For bandsEnergy columns, the column names are missing suffixes -X / -Y / -Z
   Create a Table with row indices of bandsEnergy and corresponding suffixes
   There are three types of bands Energy (fBodyAcc, fBodyAccJerk, fBodyGyro) columns
   Within each type there are group of columns for three axes (X, Y, Z)
   Hence there are total of nine set of columns (three types X three axes)

1. Find the indices of column names that needs fixing and store it in dup_features
2. Determine the number of sets of names for each axes and store it in eachVal.
3. Since each set has data for three axes, determine the number of columns there are per axis and store it in timesVal
4. Create a list of suffixes by repeating the sequence "-x", "-Y", "-Z" each by eachVal and do it timesVal times and store it in dup_dim
5. Add dup_dim as column in dup_features
   Now we have a table (dup_features) that consists of indices of features that have duplicates, and the corresponding suffixes to be added to unduplicate. 
6. dup_features has two column (indices and suffixes), and hence set the column name accordingly
7. Convert features data from factor to character
8. Add corresponding suffixes for rows with duplicate names
9. Convert features data back to original format

## Read Test Data

1. Read Test data and convert into dplyr compatible table into testData
2. Set column names for testData from features
3. Select only the columns that contains "mean" and "std"
4. Add coulmn for activity and subject from previously read data

## Read Train Data

Repeat the procedure for Test on Train data

## Combine Test and Train Data

Join test and train data into Data
Get rid of test and train data 

## Average for mean and std by groups of activity and subject

Group data by activity and subject
Using summarise find the average 
Store it in newData

## Write out the data

Using write.table write the above data in a file named "tidy.txt"




