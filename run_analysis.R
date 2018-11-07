rm(list = ls())

library(dplyr)
library(tidyr)

########################################################################
#Task1: merge train and test datasets of various sets
########################################################################

#Read Measurement Training and test datasets
dfMsrTrain <- read.csv(file="D:\\Personal\\UCI HAR Dataset\\train\\X_train.txt", header = FALSE, sep = "")
dfMsrTest <- read.csv(file="D:\\Personal\\UCI HAR Dataset\\test\\X_test.txt", header = FALSE, sep = "")
dfMSR <- rbind(dfMsrTrain,dfMsrTest) 

#Read Activity Training and test datasets
dfActTrain <- read.csv(file="D:\\Personal\\UCI HAR Dataset\\train\\y_train.txt", header = FALSE, sep = "")
dfActTest <- read.csv(file="D:\\Personal\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE, sep = "")
dfAct <- rbind(dfActTrain,dfActTest) 
colnames(dfAct) <- "ActivityId"

#Read subject Training and test datasets
dfSubTrain<-read.table("D:\\Personal\\UCI HAR Dataset\\train\\subject_train.txt") #Read the subject data for training
dfSubTest<-read.table("D:\\Personal\\UCI HAR Dataset\\test\\subject_test.txt") #Read the subject data for test
dfSub <- rbind(dfSubTrain,dfSubTest)
colnames(dfSub) <- "SubjectId"

#Read features
dfFeatures <- read.csv(file="D:\\Personal\\UCI HAR Dataset\\features.txt", header = FALSE, sep = "")
dfFeatures$V1 <- NULL

#Assign featurenames to the data 
colnames(dfMSR) <- dfFeatures[,1]

#Attach Activity and Subject
dfMSR <- cbind(dfMSR,dfAct, dfSub)

#Convert ActivityId and SubjectId to factor
dfMSR$ActivityId <- as.factor(dfMSR$ActivityId)
dfMSR$SubjectId <- as.factor(dfMSR$SubjectId)

########################################################################
#Task2: retrieve mean and sd based features
########################################################################
mean_std_names <- union(grep("mean",names(dfMSR))
                        ,grep("std",names(dfMSR))
                        ) 
dfMSR_msd <- dfMSR[,mean_std_names]
dfMSR_msd <- cbind(dfMSR_msd,dfMSR[,c("ActivityId","SubjectId")])

########################################################################
#Task3: Uses descriptive activity names to name the activities in the data set
########################################################################

dfActLabels<-read.csv(file="D:\\Personal\\UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep = "")
dfMSR_msd$Activity<-as.character(dfActLabels$V2[match(dfMSR_msd$ActivityId, dfActLabels$V1)]) 
dfMSR_msd$Activity <- as.factor(dfMSR_msd$Activity)

########################################################################
#Task4: Give descriptive variable names
########################################################################

colnames(dfMSR_msd)<-make.names(colnames(dfMSR_msd), unique=TRUE)

names(dfMSR_msd)<-gsub("Acc", "Accelerometer", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("Gyro", "Gyroscope", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("BodyBody", "Body", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("Mag", "Magnitude", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("^t", "Time", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("^f", "Frequency", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("tBody", "TimeBody", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("angle", "Angle", names(dfMSR_msd))
names(dfMSR_msd)<-gsub("gravity", "Gravity", names(dfMSR_msd))

########################################################################
#Task5: creates a second, independent tidy data set with the average of each variable for each activity and each subject
########################################################################

#Add Activity and Subject
dfTidyData <- aggregate(. ~SubjectId + ActivityId, dfMSR_msd, mean)
dfTidyData <- dfTidyData[order(dfTidyData$SubjectId,dfTidyData$ActivityId),]

## Code is given in the assignment instruction
write.table(dfTidyData, file = "TidyData.txt", row.names = FALSE)
