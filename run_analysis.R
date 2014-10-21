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
# data set is the subject id, second column in the code for the activity
# and the remaining columns are the 561 features listed in the
# features data set
features <- read.table("UCI HAR Dataset\\features.txt")
varnames <- c("subject", "activity", as.character(features$V2))
colnames(ActivityData) <- varnames


#####################################################################
# Extract only the measurements on the mean and standard deviation
# for each measurement. Variables with the word "mean" anywhere in
# the feature label are considered mean measurements and variables
# with "std" anywhere in the feature label are considered standard
# deviation measurements. The toupper() function is used to make
# certain both uppercase and lowercase instances of "mean" and "std"
# will be found
#####################################################################

# Find column indices for variables with "mean" in the variable name
meanvars <- grep("MEAN",toupper(varnames))

# Find column indices for variables with "std" in the variable name
stdvars <- grep("STD",toupper(varnames))

# Use vectors of indices created above to select columns for mean and 
# standard deviation variables
Activity_Mean_Std <- ActivityData[ , c(1, 2, meanvars,stdvars)]


#####################################################################
#  Add descriptive activity names to the activities in the data set
#####################################################################

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
library(plyr)
Activity_Summary <- ddply(Activity_Mean_Std, .(subject, activity), numcolwise(mean))


#####################################################################
# Create a text version of the summary data set created above
# for course project submission
#####################################################################
write.table(Activity_Summary, file="Activity_Summary.txt", row.name=FALSE)