library(plyr)
#Read in Data and assign column names
features <- read.table("features.txt", stringsAsFactors = FALSE)
xTrain <- read.table("X_train.txt", col.names=features$V2)
yTrain <- read.table("Y_train.txt", col.names=c("Activity Label"))
xTest <- read.table("X_test.txt",   col.names=features$V2)
yTest <- read.table("Y_test.txt",   col.names=c("Activity Label"))
subjectTest <- read.table("subject_test.txt", col.names=c("Subject"))
subjectTrain <- read.table("subject_train.txt", col.names=c("Subject"))
activityLabels <- read.table("activity_labels.txt")

#Combine subject with data sets
MS <- cbind(subjectTest, xTest)
MS2 <- cbind(subjectTrain, xTrain)

#Combine data sets
M <- rbind(MS, MS2)

#Subset for std/mean/subject
std_Col <- grep("std()", names(M))
mean_Col <- grep("mean()", names(M))
std_mean_Data <- M[, c(1, std_Col, mean_Col)]

#From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable 
#for each activity and each subject.
#Create New Data Set
Split_Data <- split(std_mean_Data, std_mean_Data$Subject)
NewData <- colMeans(Split_Data[[1]])
for (n in 2:length(Split_Data)) {
   NewData <- rbind(NewData, colMeans(Split_Data[[n]]))
}
write.table(NewData, file="ProjectOouput.txt", row.names=FALSE)
