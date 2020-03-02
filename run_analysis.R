

#1 ----------------------------------------------------------------------------------------------------------------------------------------------------------

library(dplyr)

# Importing data from downloaded repository in my PC
# Train
X_train <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
# Test
X_test <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

# PLAN: I'M GOING TO CREATE 3 DATASETS: X, y AND subj that correspond to rbinding X_train and X_test; y_train and y_test; and subject_train and subject_test respectively.
# THEN, I'LL CBIND THEM TO COMPLETE THE TASK.

# Merging X_train and X_test
dim(X_train); dim(X_test)
# [1] 7352  561
# [1] 2947  561
X <- rbind(X_train,X_test)
dim(X)
# [1] 10299   561

# Merging y_train and y_test
dim(y_train); dim(y_test)
# [1] 7352    1
# [1] 2947    1
y <- rbind(y_train,y_test)
dim(y)
# [1] 10299     1

# Merging subjects' sets
dim(subject_train); dim(subject_test)
# [1] 7352    1
# [1] 2947    1
subj <- rbind(subject_train,subject_test)
dim(subj)
# [1] 10299     1

# Binding all 3 sets by column
union <- cbind(X, y, subj)
dim(union)
# [1] 10299   563


# 2 ----------------------------------------------------------------------------------------------------------------------------------------------------------
# Features
features <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
# Naming variables according to features set
dim(features)
# [1] 561   2
str(features)
# $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
# $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...

# Since features$V2 is a factor, I'll have to transform it into a character vector so I can name my data set properly
colnames(union) <- c(as.character(features$V2), "Activity", "Subject")
head(union)

# Identifying columns with "mean" and "std" in their names
cols_mean_std <- names(union[,(grepl("[Mm][Ee][Aa][Nn]",names(union))|grepl("[Ss][Tt][Dd]",names(union)))])

# Creating the new data set with just the mean-std columns
meanstd <- dplyr::select(union, c(cols_mean_std, Activity, Subject))
# Error: Can't bind data because some arguments have the same name

# Since I have some column names that are equal to others, I'll add an index to the features names so they can be differenciated between each other.
# I'll use features$V1 to index the names
features2 <- paste(features$V1,".",features$V2, sep = "")
colnames(union) <- c(features2, "Activity", "Subject")

# Selecting only the features with mean and std in their name (again)
cols_mean_std <- names(union[,(grepl("[Mm][Ee][Aa][Nn]",names(union)) | grepl("[Ss][Tt][Dd]",names(union)))])
meanstd <- dplyr::select(union, c(cols_mean_std, Activity, Subject))
dim(meanstd)
# [1] 10299    88


# 3 ----------------------------------------------------------------------------------------------------------------------------------------------------------

activity_labels <- read.table("Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
head(activity_labels)
str(activity_labels) # activity_labels$V2 is a factor variable, so I'll have to convert it into a character variable
activity_labels$V2 <- as.character(activity_labels$V2)
str(activity_labels$V2)
# $ V2: chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...

# Labeling ativities
meanstd$activity_names <- activity_labels[meanstd$Activity,2]

# Validating frequencies between Activity column and the new activity_names column
table(meanstd$Activity);table(meanstd$activity_names)
# 1    2    3    4    5    6 
# 1722 1544 1406 1777 1906 1944 
# LAYING            SITTING           STANDING            WALKING WALKING_DOWNSTAIRS   WALKING_UPSTAIRS 
# 1944               1777               1906               1722               1406               1544 

dim(meanstd)
# [1] 10299    89


# 4 ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Renaming column names according to features_info.txt file so they be more descriptive
names(meanstd) <- gsub("Acc", "Accelerometer", names(meanstd))
names(meanstd) <- gsub("Gyro", "Gyroscope", names(meanstd))
names(meanstd) <- gsub("BodyBody", "Body", names(meanstd))
names(meanstd) <- gsub("Mag", "Magnitude", names(meanstd))
names(meanstd) <- gsub("[.][t]", ".Time", names(meanstd))
names(meanstd) <- gsub("[.][f]", ".Frequency", names(meanstd))
names(meanstd) <- gsub("tBody", "TimeBody", names(meanstd))
names(meanstd) <- gsub("-mean()", "Mean", names(meanstd), ignore.case = TRUE)
names(meanstd) <- gsub("-std()", "STD", names(meanstd), ignore.case = TRUE)
names(meanstd) <- gsub("-freq()", "Frequency", names(meanstd), ignore.case = TRUE)
names(meanstd) <- gsub("angle", "Angle", names(meanstd))
names(meanstd) <- gsub("gravity", "Gravity", names(meanstd))

# Validating the new column names
names(meanstd)

dim(meanstd)
# [1] 10299    89


# 5 ----------------------------------------------------------------------------------------------------------------------------------------------------------

# Using meanstd dataset, I'll group by the Subject and activity_names variables and then I'll calculate the mean for the rest of the variables.
final <- meanstd %>%
        group_by(Subject, activity_names) %>%
        summarise_all(mean)

dim(final)
# [1] 180  89
# 30 subjects x 6 activities = 180 rows

# Writing final set to project folder.
write.table(final, "Y:/DATA SCIENCE/Johns Hopkins University Data Science Course/3 Getting and Cleaning Data/Week 4/Peer Graded Assignment/Final.txt", row.names = FALSE)


# ----------------------------------------------------------------------------------------------------------------------------------------------------------
#Validating NAs in the dataset
table(is.na(final))




dplyr::select(final, Subject, activity_names, Activity)




































































