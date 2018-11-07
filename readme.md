This exercise is about producing a tidy data set of the observations gathered during a study done using the accelerometers from the Samsung Galaxy S smartphone. A full description of the studu is available at: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

========================================
HOW TO USE THIS PROGRAM
========================================
Outputs of this R Script:
   	a.merges all the test and train data sets including observations, labels, subjects
	b.extracts the measurements related to mean and standard deviation
	c.Make the given variables valid and attach the variable names to the dataset
	d.Tidyup the data and include mean values of the varaibles for each subject and each activity 

1. Download the zip file from the above link
2. Unzip it and store it in your working directory
3. Change the R script to point to the working directory
4. Run this R script
	
========================================
HOW THIS PROGRAM OPERATES
========================================

1. Reads all the data sets (measurements, activity and Subject data set) from train and test folders 
2. Reads the variabe names and assigns them to the data frame
3. Filters the mean and standard variation related variable names i.e. all the variable names that have mean or std in them
4. Converts all the R incompatible column names to valid ones using
5. Finally it outputs average of all the features for all the combinations of Activity and Subjects
