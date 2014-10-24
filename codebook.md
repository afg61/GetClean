
# CODEBOOK  
## Smartphone Human Activity Recognition Summary Dataset

The Smartphone Human Activity Recognition Summary Dataset provides a summary of smartphone measurements collected for 30 subjects performing six different activities.

## Raw Data
Raw data for the Smartphone Human Activity Recognition Summary Data Set (Activity_Summary.txt) are taken from the Human Activity Recognition Using Smartphones Dataset Version 1.0 prepared by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto at Smartlab - Non Linear Complex Systems Laboratory, DITEN - Università degli Studi di Genova, Via Opera Pia 11A, I-16145, Genoa, Italy (activityrecognition@smartlab.ws, www.smartlab.ws).  A detailed description of the raw data provided by the original data collectors is included in Appendix A.
Raw data used to create the summary data set include: a subject id (1-30), a code to identify the activity the subject was performing (1=walking, 2=walking upstairs, 3=walking downstairs, 4=sitting, 5=standing, 6=laying), and 561 time and frequency domain variables measured by the smartphone while the subject performed that activity. Feature variables are normalized and bounded within [-1,1].
The data authors provided the raw data split into training and test sets.  The summary data set combined all of these data to create a summary data file with summary measures for all 30 participants.  Data for the summary data set were taken from the following files: subject id (from subject_train.txt and subject_test.txt), activity code (from y_train.txt and y_test.txt), and feature variables (from x_train.txt and x_test.txt).

Raw data were downloaded from on October 20 from
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Processed Data
Steps performed to create the summary data set Activity_Summary.txt from the raw data:

- Combine data from multiple files to create a single file with subject id, activity id, and feature data for all 30 subjects. This involved combining 3 data frames for the training group (with subject id, activity code, and feature data) and 3 data frames for the test group (with subject id, activity, and feature data) then combining the training and test data sets into a single data set.
- Add column names to the data set to identify the columns.  The original study authors provided a text file features.txt with descriptive names for the features that could be used as column names. Cleaned up variable names were created by pulling pieces of information from the variable names in features.txt and pasting these together to create new variable names following the set pattern described below. These variable names include important information about what each feature variable contains but use abbreviations to keep them from being overly long. 


- Select only the features involving mean or standard deviation measurements.  It was assumed that all features with either “mean” or “std” in the feature description were of interest.

- The study authors provided descriptive labels for the activity codes in a text file activity_labels.txt.  The activity variable was converted to a factor with 6 levels and the descriptive labels were used as factor levels to make it clear to data users what the activities were.

- The original data set included multiple observations for each subject performing each of the six activities.  The summary data set averages across these multiple observations to provide an average measurement for each included feature for each subject and each activity. 
- The data were written to a text file Activity_Summary.txt to make the data available to a wide array of users working with a variety of software packages.


## Variable List

**Subject** 
- Subject ID. An integer ranging from 1-30

**Activity**
- Activity being performed by the subject when the measurement was taken. Factor variable with 6 levels. 
	+ 1=walking 
	+ 2=walking upstairs 
	+ 3=walking downstairs 
	+ 4=sitting 
	+ 5=standing 
	+ 6=laying

**Feature Variables** 
- 561 feature variables created from data collected by the smart phone accelerometer and gyroscope while the subject was performing the various activities.  Feature variables are standardized to range in value from -1 to 1.  Standardizing the variables in this way makes them unitless.  Feature variables were named according to rules described below which include information about what each variable represents.



## Variable Naming for Feature Variables

To make the feature variable names understandable without
making them too long, variable names were constructed following a set
pattern of abbreviations conveying important information about the variable.

- Measurement domain
	+ t = time 
	+ f = frequency 
	+ first character not t or f = other domain

- Measurement Source 
	+ body = measurement from body movement 
	+ gravity = measurement from gravity

- Recording Device 
	+ acc = accelerometer 
	+ gyro = gyroscope

- Jerk Measurement? 
	+ jerk = jerk measurement 
	+ if "jerk" not present in name, not jerk measurement

- Magnitude Measurement? 
	+ mag = magnitude measurement 
	+ if "mag" not present in name, not magnitude measurement

- Summary type 
	+ meanfreq = mean frequency 
	+ mean = mean 
	+ std = standard deviation

- Measurement Plane 
	+ x = x plane 
	+ y = y plane 
	+ z = z plane


Feature variable names were created by pasting together the abbreviations representing each piece of information in the order listed above.


## Appendix A 
### Description of the raw data provided by the original data collectors
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
Each record includes:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- The activity label 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

Feature Selection:
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean


For more information about this dataset contact: activityrecognition@smartlab.ws

License: 
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
