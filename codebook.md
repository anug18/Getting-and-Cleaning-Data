CODEBOOK:

1) Original data Files Used and their description:

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

2) Activity Mapping :
ActivityId : Activity Name
	  	1 WALKING

		2 WALKING_UPSTAIRS

		3 WALKING_DOWNSTAIRS

		4 SITTING

		5 STANDING

		6 LAYING
  
3) Subject: 30 Subjects

4) Data Transformation:

-Train and Test data for Measurements,Activity, Subject are merged into their respective dataframes
-ActivityId is resolved to its coresponding name from "activity-labels.txt" mapping data
-ONLY mean and standard deviation columns are considered for analysis
-ActivityId, ActivityName, and SubjectId are converted to factors
-Average of all the columns for Activity(6 count) and Subject (30 count), total 180 rows is the output
