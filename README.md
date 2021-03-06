# GetClean
========

## Smartphone Human Activity Recognition Summary Dataset

### Files for this project include:

- An R script run_analysis.R that creates a tidy data set in text format (Activity_Summary.txt)
- A codebook describing the raw data used to create the summary data set and the steps involved

### Using the script run_analysis.R
In order to use the R script run_analysis.R, a user must:

- Download the zipped raw Smart Phone activity data from
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

- Unzip the raw data

- Set the working directory in R to be the directory where the unzipped raw data reside

### Description of the data processing script run_analysis.R

Steps performed in run_analysis.R to create the summary data set Activity_Summary.txt from the raw data:

- Combine data from multiple files to create a single file with subject id, activity id, and feature data for all 30 subjects. This involved combining 3 data frames for the training group (with subject id, activity code, and feature data) and 3 data frames for the test group (with subject id, activity, and feature data) then combining the training and test data sets into a single data set.

- Add column names to the data set to identify the columns.  The original study authors provided a text file features.txt with descriptive names for the features that could be used as column names. Names from features.txt were cleaned up to remove special characters and to convert to all lowercase for ease of use and compatibility with other programs.
Cleaned up variable names were created by pulling pieces of information from the variable names in features.txt and pasting these together to create new variable names following the set pattern described below. These variable names include important information about what each feature variable contains but use abbreviations to keep them from being overly long. 

	+ Measurement domain
		+ t = time 
		+ f = frequency 
		+ first character not t or f = other domain

	+ Measurement Source 
		+ body = measurement from body movement 
		+ gravity = measurement from gravity

	+ Recording Device 
		+ acc = accelerometer 
		+ gyro = gyroscope

	+ Jerk Measurement? 
		+ jerk = jerk measurement 
		+ if "jerk" not present in name, not jerk measurement

	+ Magnitude Measurement? 
		+ mag = magnitude measurement 
		+ if "mag" not present in name, not magnitude measurement

	+ Summary type 
		+ meanfreq = mean frequency 
		+ mean = mean 
		+ std = standard deviation

	+ Measurement Plane 
		+ x = x plane 
		+ y = y plane 
		+ z = z plane


- Select only the features involving mean or standard deviation measurements.  It was assumed that all features with either �mean� or �std� in the feature description were of interest.

- The study authors provided descriptive labels for the activity codes in a text file activity_labels.txt.  The activity variable was converted to a factor with 6 levels and the descriptive labels were used as factor levels to make it clear to data users what the activities were.

- The original data set included multiple observations for each subject performing each of the six activities.  The summary data set averages across these multiple observations to provide an average measurement for each included feature for each subject and each activity. 

- The data were written to a text file Activity_Summary.txt to make the data available to a wide array of users working with a variety of software packages.

- A codebook was created to describe the data set and the steps involved in creating it.

