# GetClean
========

## Smartphone Human Activity Recognition Summary Dataset

### Files for this project include:

- An R script run_analysis.R that creates a tidy data set in text format (Activity_Summary.txt)
- A codebook describing the raw data used to create the summary data set and the steps involved

### Description of the data processing script run_analysis.R

Steps performed in run_analysis.R to create the summary data set Activity_Summary.txt from the raw data:

- Combine data from multiple files to create a single file with subject id, activity id, and feature data for all 30 subjects. This involved combining 3 data frames for the training group (with subject id, activity code, and feature data) and 3 data frames for the test group (with subject id, activity, and feature data) then combining the training and test data sets into a single data set.
- Add column names to the data set to identify the columns.  The original study authors provided a text file features.txt with descriptive names for the features that could be used as column names. Names from features.txt were cleaned up to remove special characters and to convert to all lowercase for ease of use and compatibility with other programs.
- Select only the features involving mean or standard deviation measurements.  It was assumed that all features with either “mean” or “std” in the feature description were of interest.
- The study authors provided descriptive labels for the activity codes in a text file activity_labels.txt.  The activity variable was converted to a factor with 6 levels and the descriptive labels were used as factor levels to make it clear to data users what the activities were.
- The original data set included multiple observations for each subject performing each of the six activities.  The summary data set averages across these multiple observations to provide an average measurement for each included feature for each subject and each activity. 
- The data were written to a text file Activity_Summary.txt to make the data available to a wide array of users working with a variety of software packages.
- A codebook was created to describe the data set and the steps involved in creating it.

