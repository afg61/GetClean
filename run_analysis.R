#####################################################################
###
###             Getting and Cleaning Data Course Project
###
###
#####################################################################


#####################################################################
# Merge the training and test sets to create one data set
#    (assumes data is in current working directory)
#####################################################################

# Read in Training data and combine subject id, activity, and features into
# a single data frame - subject in 1st column, activity code in 2nd column
# and feature measurements in columns 3-563
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
Xtrain <- read.table("UCI HAR Dataset\\train\\X_train.txt")
Ytrain <- read.table("UCI HAR Dataset\\train\\y_train.txt")
Train <- cbind(subject_train, Ytrain, Xtrain)

# Read in Test data and combine subject id, activity, and features into
# a single data frame - subject in 1st column, activity code in 2nd column
# and feature measurements in columns 3-563
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
Xtest <- read.table("UCI HAR Dataset\\test\\X_test.txt")
Ytest <- read.table("UCI HAR Dataset\\test\\y_test.txt")
Test <- cbind(subject_test, Ytest, Xtest)

# Combine Training and Test data into a single data frame.
ActivityData <- rbind(Train,Test)


#####################################################################
#  Appropriately label the data set with descriptive variable names 
#####################################################################

# Read in data set of feature names and use these features names to
# name the features columns in the data set. First column in the
# data set is the subject id, second column is the code for the activity
# and the remaining columns are the 561 features listed in the
# features data set
features <- read.table("UCI HAR Dataset\\features.txt")
varnames <- c("subject", "activity", as.character(features$V2))

# Clean up varnames to make them easier to use -- remove special
# characters and convert to all lowercase
varnames <- tolower(gsub("[[:punct:]]", "", varnames))

colnames(ActivityData) <- varnames


#####################################################################
# Extract only the measurements on the mean and standard deviation
# for each measurement. Variables with the word "mean" anywhere in
# the feature label are considered mean measurements and variables
# with "std" anywhere in the feature label are considered standard
# deviation measurements.
#####################################################################

# Find column indices for variables with "mean" in the variable name
meanvars <- grep("mean",varnames)

# Find column indices for variables with "std" in the variable name
stdvars <- grep("std",varnames)

# Use vectors of indices created above to select columns for mean and 
# standard deviation variables. Also include columns 1 and 2 because
# these columns have data for subject id and activity
Activity_Mean_Std <- ActivityData[ , c(1, 2, meanvars,stdvars)]


#####################################################################
#  Add descriptive activity names to the activities in the data set
#####################################################################

# File activity_labels.txt has labels for activity levels
activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt", as.is=TRUE)

# Convert activity variable to a factor and assign labels to the levels
Activity_Mean_Std$activity <- factor(Activity_Mean_Std$activity, 
                                     levels=activity_labels$V1,
                                     labels=activity_labels$V2)


#####################################################################
# Create an independent tidy data set with the average of each
# variable for each activity and each subject
#####################################################################

# Average of each variable for each activity for each subject
# ddply function is used to summarize the data set so need to
# load the plyr package
library(plyr)
Activity_Summary <- ddply(Activity_Mean_Std, .(subject, activity), numcolwise(mean))


#####################################################################
# Create a text version of the summary data set created above
# for course project submission
#####################################################################
write.table(Activity_Summary, file="Activity_Summary.txt", row.name=FALSE)