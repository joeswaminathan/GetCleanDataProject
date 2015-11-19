load <- function() {
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl, destfile = "getdata_projectfiles_UCI HAR Dataset.zip")
    unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}

run_analysis <- function() 
{
    library(data.table)
    library(dplyr)
    library(tidyr)
    
#    load()
    
    # Read Activity Labels
    activityLbls <- read.csv("UCI_HAR_Dataset/activity_labels.txt", sep="", header = FALSE, strip.white = TRUE)

    # Read Test & Train Activity data, and convert the numeric to readable Activity Label
    testActivty  <- read.csv("UCI_HAR_Dataset/test/y_test.txt",     sep="", header = FALSE, strip.white = TRUE) %>% tbl_df %>% mutate(V1 = activityLbls[V1, 2])
    trainActivty <- read.csv("UCI_HAR_Dataset/train/y_train.txt",   sep="", header = FALSE, strip.white = TRUE) %>% tbl_df %>% mutate(V1 = activityLbls[V1, 2])

    rm(activityLbls)

    # Read Test & Train Subject data
    testSubject  <- read.csv("UCI_HAR_Dataset/test/subject_test.txt",     sep="", header = FALSE, strip.white = TRUE)
    trainSubject <- read.csv("UCI_HAR_Dataset/train/subject_train.txt",   sep="", header = FALSE, strip.white = TRUE)
    
    # Read Column names from features data
    features            <- read.csv("UCI_HAR_Dataset/features.txt",        sep="", header = FALSE, strip.white = TRUE) %>% select(-V1)
    
    # Fix duplicate column names
    # 	For bandsEnergy columns, the column names are missing suffixes -X / -Y / -Z
    # 	Create a Table with row indices of bandsEnergy and corresponding suffixes
    # 	There are three types of bands Energy (fBodyAcc, fBodyAccJerk, fBodyGyro) columns
    # 	Within each type there are group of columns for three axes (X, Y, Z)
    # 	Hence there are total of nine set of columns (three types X three axes) 
    
    ## Create a table with indeces of features that needs to be fixed (add suffix)
    dup_features        <- grep("bandsEnergy", features$V2) %>% data.frame
    ## Determine the number of sets
    eachVal             <- nrow(dup_features)/9            #  Three types of data, for three axis
    ## Determine the count of columns in each set for each axes
    timesVal            <- nrow(dup_features)/eachVal/3    #  Sets of data for each axis
    ## Create the list of suffixes
    dup_dim             <- rep(c("-X", "-Y", "-Z"), each = eachVal, times = timesVal)
    ## Add suffixes to the table 
    dup_features$dim    <- dup_dim
    ## Set column names for this table
    names(dup_features) <- c("index", "dim")
    
    ## Change feature names to characters from factors
    features$V2 <- as.character(features$V2)
    ## Add suffixes
    features$V2[dup_features$index] <- paste(features$V2[dup_features$index], dup_features$dim, sep="")
    ## Convert back to factor
    features$V2 <- as.character(features$V2)
    
    # Read Test data and select only the columns for mean and standard deviation
    testData           <- read.csv("UCI_HAR_Dataset/test/X_test.txt",     sep="", header = FALSE, strip.white = TRUE) %>% tbl_df 
    names(testData)    <- features[,1]
    testData           <- select(testData, contains("mean()"), contains("std()"))
    # Add the activity and subject data
    testData$activity  <- testActivty$V1
    testData$subject   <- testSubject$V1

    # Read Train data and select only the columns for mean and standard deviation
    trainData          <- read.csv("UCI_HAR_Dataset/train/X_train.txt",   sep="", header = FALSE, strip.white = TRUE) %>% tbl_df 
    names(trainData)   <- features[,1]
    trainData          <- select(trainData, contains("mean()"), contains("std()"))
    # Add the activity and subject data
    trainData$activity <- trainActivty$V1
    trainData$subject  <- trainSubject$V1
    
    # Join both Test and Train data
    Data <- full_join(testData, trainData) 
    
    rm(trainData)
    rm(testData)
    
    # Group data by activity and subject and calculate mean for each group
    newData <- group_by(Data, activity, subject) %>% summarise_each(funs(mean))

    # Write tidy data to the file
    write.table(newData, file="tidy.txt", row.names = FALSE)

}
