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

#Read subject Training and test datasets
dfSubTrain<-read.table("D:\\Personal\\UCI HAR Dataset\\train\\subject_train.txt") #Read the subject data for training
dfSubTest<-read.table("D:\\Personal\\UCI HAR Dataset\\test\\subject_test.txt") #Read the subject data for test
dfSub <- rbind(dfSubTrain,dfSubTest)

#Read features
dfFeatures <- read.csv(file="D:\\Personal\\UCI HAR Dataset\\features.txt", header = FALSE, sep = "")
dfFeatures$V1 <- NULL

#Assign featurenames to the data 
colnames(dfMSR) <- dfFeatures[,1]

########################################################################
#Task2: retrieve mean and sd based features
########################################################################
mean_std_names <- union(grep("mean",names(dfMSR))
                       ,grep("std",names(dfMSR))) 
dfMSR_msd <- dfMSR[,mean_std_names]

########################################################################
#Task3: Uses descriptive activity names to name the activities in the data set
########################################################################

dfActLabels<-read.csv(file="D:\\Personal\\UCI HAR Dataset\\activity_labels.txt", header = FALSE, sep = "")
dfAct$Activity<-as.character(dfActLabels$V2[match(dfAct$V1, dfActLabels$V1)]) 

dfMSR_msd$Activity<-dfAct$Activity # Now attache the descriptive activity names to the data set 

########################################################################
#Task4: Give descriptive variable names
########################################################################

colnames(dfMSR_msd)<-make.names(colnames(dfMSR_msd), unique=TRUE)

########################################################################
#Task5: creates a second, independent tidy data set with the average of each variable for each activity and each subject
########################################################################
meanColumns <- names(dfMSR[,grep("mean",names(dfMSR))])

dfMean <- dfMSR_msd[,c(make.names(meanColumns),"Activity")]

dfMean$Subject<-dfSub[,"V1"]
