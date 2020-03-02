The run_analysis.R script goes through the instructions in the Getting and Cleaning Data Course project:

1. Merges the training and the test sets to create one data set:
- Importing the dataset
Dataset downloaded and extracted under the folder ./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset
- Creating R objects for each data set imported:
X_train <- ./train/X_train.txt (Rows: 7352, Columns: 561)
y_train <- ./train/y_train.txt (Rows: 7352, Columns: 1)
subject_train <- ./train/subject_train.txt (Rows: 7352, Columns: 1)
X_test <- ./test/X_test.txt (Rows: 2947, Columns: 561)
y_test <- ./test/y_test.txt (Rows: 2947, Columns: 1)
subject_test <- ./test/subject_test.txt (Rows: 2947, Columns: 1)
- Creating 3 sets: X, y and subj
X is created by merging X_train and X_test using the rbind() function (Rows: 10299, Columns: 561).
y is created by merging y_train and y_test using the rbind() function (Rows: 10299, Columns: 1).
subj is created by merging subject_train and subject_test using the rbind() function (Rows: 10299, Columns: 1).
- Merging the 3 datasets to complete the task
"union" set is created by merging X, y and subj using the cbind() function (Rows: 10299, Columns: 563).


2. Extracts only the measurements on the mean and standard deviation for each measurement:
- Importing column names
features <- ./features.txt
- Assigning column names to the "union" data set based on features set.
Transforming features$V2 into character first (since it was imported as a factor variable) and then, using colnames() function, assigning features$V2, "Activity" and "Subject" as the names of the "union" set columns.
- Identifying columns with "mean" and "std" in their names
"cols_mean_std" is created by using the grepl() function to identify column names with "mean" or "std" within their names.
- Subsetting dataset with only the "mean" and "std" columns
Using select() function (dplyr package) to create a smaller data set with the column names contained in "cols_mean_std", along with "Activity" and "Subject" columns.
- Changing column names since features names are not unique
Having that features.txt had a column called "V1" indexing the column names from 1 through 561, a "features2" variable is created pasting features$V1 and features$V2 so every variable is differenciated from one another.
- Identifying columns with "mean" and "std" in their names (again)
"cols_mean_std" is created by using the grepl() function to identify column names with "mean" or "std" within their names.
- Subsetting dataset with only the "mean" and "std" columns (again)
"meanstd" data set is created by using select() function (dplyr package) to subset the "union" data set with the column names contained in "cols_mean_std", along with "Activity" and "Subject" columns (Rows: 10299, Columns: 88).


3. Uses descriptive activity names to name the activities in the data set
- Importing activity labels set
activity_labels <- ./activity_labels.txt (Rows: 6, Columns: 2)
- Creating activity_names column
meanstd$activity_names is created using activity_labels set, identifying with "Activity" column the corresponding activity description.


4. Appropriately labels the data set with descriptive variable names.
Changing column names based on features_info.txt file for these character strings:
All "Acc" in column names were changed to "Accelerometer"
All "Gyro" in column names were changed to "Gyroscope"
All "BodyBody" in column names were changed to "Body"
All "Mag" in column names were changed to "Magnitude"
All ".t" in column names were changed to ".Time"
All ".f" in column names were changed to ".Frequency"
All "tBody" in column names were changed to "TimeBody"
All "-mean()" in column names were changed to "Mean"
All "-std()" in column names were changed to "STD"
All "-freq()" in column names were changed to "Frequency"
All "angle" in column names were changed to "Angle"
All "gravity" in column names were changed to "Gravity"


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- "final" data set is created by grouping the data by "Subject" and "activity_names" and then applying the summarise_all() function to calculate the mean on the rest of the variables (Rows: 180, Columns: 89).
- Using write.table to write "final" set to project folder.
