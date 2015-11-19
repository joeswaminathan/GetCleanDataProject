# GetCleanDataProject

## About Data

   The gory details of data are given in features_info.txt 
   Hence I am going to explain only what is relevant to this exercise

   Various measurements were taken on sample subjects a total of 561 of them
   What each measurment (column) means is given in
        features.txt features_inf.txt

   The data collected is divided into two sets one to be used for training and other for test
   For each sample subject these measurments were taken while they were
       doing the following activities
        1. WALKING
	2. WALKING_UPSTAIRS
	3. WALKING_DOWNSTAIRS
	4. SITTING
	5. STANDING
	6. LAYING
   Hence there are six rows per sample.

   The data is recorded in file with six rows per sample subjects
        train/X_train.txt & test/X_test.tx
   For each row in the above data, 
      the corresponding activity is recorded in
        train/y_train.txt & test/y_test.txt
	The activities are number coded and numbers explained in 
	   activity_labels.txt
      the subject that performed the test is recorded in
        train/subject_train.txt & test/subject_test.txt

## Results required

   Out of 561 measurements, we need the average for those measurements
   that are mean and standard deviations

   We need this average per activity and subject. 
        
## Algorithm

   Since the average is asked only for mean and std deviations 
       ignore the data for "Inertial Signals"

   First convert the activity data to a human readable data by 
       replacing the numbers with the activity labels

   The measurement on three axes are suffixed with the axes labels X, Y & Z
       in the column name. But for the measurment bandsEnergy the suffixes
       are missing. These suffixes are added

   Read the test data (561 measurements) and set column names (features)
       Select only those columns that are mean or standard deviation
       Add columns activity and subject read from acivity and subject file

   Repeat the above for training data

   Join both the data set to form a single data set

   Calculate average per activity and subject



