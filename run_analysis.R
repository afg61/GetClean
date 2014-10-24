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
vnames <- c("subject", "activity", as.character(features$V2))

# Clean up varnames to make them easier to extract means and std 
# -- remove special characters and convert to all lowercase
# Variable names cleaned up below after subsetting
vnames <- tolower(gsub("[[:punct:]]", "", vnames))

colnames(ActivityData) <- vnames


#####################################################################
# Extract only the measurements on the mean and standard deviation
# for each measurement. Variables with the word "mean" anywhere in
# the feature label are considered mean measurements and variables
# with "std" anywhere in the feature label are considered standard
# deviation measurements.
#####################################################################

# Find column indices for variables with "mean" in the variable name
meanvars <- grep("mean",vnames)

# Find column indices for variables with "std" in the variable name
stdvars <- grep("std",vnames)

# Use vectors of indices created above to select columns for mean and 
# standard deviation variables. Also include columns 1 and 2 because
# these columns have data for subject id and activity
Activity_Mean_Std <- ActivityData[ , c(1, 2, meanvars,stdvars)]


#####################################################################
# Clean up variable names. To make variables understandable without
# making them too long, construct variable names following a set
# pattern of abbreviations conveying important information
# 
# First character = measurement domain
#    t = time
#    f = frequency
#    first character not t or f = other domain
#
# Measurement Source
#    body = measurement from body movement
#    gravity = measurement from gravity
#
# Recording Device
#    acc = accelerometer
#    gyro = gyroscope
#
# Jerk Measurement?
#    jerk = jerk measurement
#    if "jerk" not present in name, not jerk measurement
#
# Magnitude Measurement?
#    mag = magnitude measurement
#    if "mag" not present in name, not magnitude measurement
#
# Summary type
#    meanfreq = mean frequency
#    mean = mean
#    std = standard deviation
#
# Measurement Plane
#    x = x plane
#    y = y plane
#    z = z plane
#
#
# Variable names are created in pieces and then pasted together in the
# pattern described above
#####################################################################

varnames <- names(Activity_Mean_Std)

#### SOURCE OF SIGNAL ###
tbody <- grepl("tbody",varnames)
fbody <- grepl("fbody",varnames)
tgravity <- grepl("tgravity",varnames)
fgravity <- grepl("fgravity",varnames)
gravity <- grepl("gravity",varnames)

msource <- character(length=88)
for (i in 1:88){
        if(tbody[i]==TRUE){
                msource[i] <- "tbody"     
        } else {
                if(fbody[i]==TRUE){
                        msource[i] <- "fbody"  
                } else {
                        if (tgravity[i]==TRUE){
                                msource[i] <- "tgravity"
                        } else {
                                if (fgravity[i]==TRUE){
                                        msource[i] <- "fgravity"
                                } else {
                                        if (gravity[i]==TRUE){
                                                msource[i] <- "gravity"
                                        }
                                }}}}
}

#### RECORDING DEVICE ###
acc <- grepl("acc",varnames)
gyro <- grepl("gyro",varnames)
angle <- grepl("angle",varnames)

mdevice <- character(length=88)
for (i in 1:88){
        if(acc[i]==TRUE){
                mdevice[i] <- "acc"     
        } else {
                if(gyro[i]==TRUE){
                        mdevice[i] <- "gyro"  
                } else {
                        if(angle[i]==TRUE){
                                mdevice[i] <- "angle"
                        }
                }
        }}

#### JERK MEASUREMENTS ###
jerk <- grepl("jerk",varnames)
mjerk <- character(length=88)
for (i in 1:88){
        if(jerk[i]==TRUE){
                mjerk[i] <- "jerk"
        }
}


#### MAGNITUDE MEASUREMENTS ###
mag <- grepl("mag",varnames)
mmag <- character(length=88)
for (i in 1:88){
        if(mag[i]==TRUE){
                mmag[i] <- "mag"
        }
}

#### SUMMARY TYPE ###
meanfreqx <- grepl("meanfreq",varnames)
meanx <- grepl("mean",varnames)
stdx <- grepl("std",varnames)

msummary <- character(length=88)
for (i in 1:88){
        if(meanfreqx[i]==TRUE){
                msummary[i] <- "meanfreq"     
        } else {
                if(meanx[i]==TRUE){
                        msummary[i] <- "mean"  
                } else {
                        if(stdx[i]==TRUE){
                                msummary[i] <- "std"
                        }
                }
        }}


#### MEASUREMENT PLANE ###
xplane <- grepl("x",varnames)
y1 <- grepl("ygravity",varnames)
y2 <- grepl("freqy",varnames)
y3 <- grepl("meany",varnames)
y4 <- grepl("stdy",varnames)
zplane <- grepl("z",varnames)

mplane <- character(length=88)
for (i in 1:88){
        if(xplane[i]==TRUE){
                mplane[i] <- "x"     
        } else {
                if(zplane[i]==TRUE){
                        mplane[i] <- "z"  
                } else {
                        if(y1[i]==TRUE | y2[i]==TRUE | 
                                   y3[i]==TRUE | y4[i]==TRUE){
                                mplane[i] <- "y"
                        }
                }
        }}

# Paste pieces of information together to create variable names
# following a set pattern containing information about each
# feature measurement.  Then add name for subject and activity
tidynames <- paste0(msource,mdevice,mjerk,mmag,msummary,mplane)
tidynames[1] <- "subject"
tidynames[2] <- "activity"

colnames(Activity_Mean_Std) <- tidynames



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