### run_analysis.R
## Input and Output
# input
run_analysis.R download zip file from:
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".

A brief description of the input file is:
Title: Human Activity Recognition Using Smartphones Data Set 
Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
to see more infomation:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# output
run_analysis.R write "average_data.txt"" in the working directory."average_data.txt" contaions the average of each variable for each activity and each subject. To see more infomation please refer to cookbook in this repository.

## To run run_analysis.R
R version: run_analysis.R is tested in R3.2.1
           may work correctly in earlier version
Packages:  run_analysys.R uses dplyr package

## How it works
# step1 Download and merge
Download and unzip files.Merges the training and the test sets to create one data set.
test set:     2947 obs
training set: 7352 obs.
mergerd set: 10299 obs.
Please note that the following downloaded and unziped files are used in step1 ~ step5.
"./UCI HAR Dataset/activity_labels.txt" 
             link labels and activity names
"./UCI HAR Dataset/features.txt" list of all features
"./UCI HAR Dataset/test/subject_test.txt"  test subject
"./UCI HAR Dataset/test/X_test.txt"  test set
"./UCI HAR Dataset/test/y_test.txt"  test labels
"./UCI HAR Dataset/train/subject_train.txt" trainning subject
"./UCI HAR Dataset/train/X_train.txt" trainning set
"./UCI HAR Dataset/train/y_train.txt" trainning labels

# step2 Extract mean and standard deviation
Extracts only the measurements on the mean and standard deviation for each measurement. Please note that meanFreq() variables are excluded, so 66 varibles are extracted. 

# step3 attach activity name column
Uses descriptive activity names to name the activities in the data set

# step4 name the variable columns
Appropriately labels the data set with descriptive variable names. 

# step5 create and write the average data file
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
nrow: 6 activities * 30 subjects = 180 rows
ncol: activity + subject + 66 average = 68 columns
