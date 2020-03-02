# Getting-and-Cleaning-Data-Course-Project
Repository with all files developed in this project

This repository was created by Armando Monsalve and it has the instructions on how to get, clean and tidy the Human Activity recognition dataset for future analyses.

Dataset: "Human Activity Recognition Using Smartphones Data Set"
Link to dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Files: CodeBook.md (a code book that describes the variables, the data, and any transformations or work that were performed to clean up the data)
Script: run_analysis.R (script that runs the necessary steps to get, clean and tidy the data set)

Steps developed in script:
1. Merging the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement.
3. Using descriptive activity names to name the activities in the data set
4. Appropriately labeling the data set with descriptive variable names.
5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject.

Result File: Final.txt (cleaned data according to steps mentioned above).
