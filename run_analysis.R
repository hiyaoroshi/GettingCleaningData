library(plyr)
library(dplyr)
z_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(z_url,"dataset.zip")
unzip("dataset.zip")
# "UCI HAR Dataset/activity_labels.txt" 
#             link labels and activity names
# "UCI HAR Dataset/features.txt" list of all features
# "UCI HAR Dataset/test/subject_test.txt"  test subject
# "UCI HAR Dataset/test/X_test.txt"  test set
# "UCI HAR Dataset/test/y_test.txt"  test labels
# "UCI HAR Dataset/train/subject_train.txt" trainning subject
# "UCI HAR Dataset/train/X_train.txt" trainning set
# "UCI HAR Dataset/train/y_train.txt" trainning labels
#
### step1.Merges the training and the test sets 
#         to create one data set.
testDF<-read.table("UCI HAR Dataset/test/X_test.txt")
# names(testDF)
# dim(testDF)
# head(testDF,2)
# tail(testDF,2)
trainDF<-read.table("UCI HAR Dataset/train/X_train.txt")
# names(trainDF)
# dim(trainDF)
# head(trainDF,2)
# tail(trainDF,2)
mergedDF<-rbind(testDF,trainDF)
# dim(mergedDF)
#   should be; 10299 561

### step2 Extracts only the measurements 
#         on the mean and standard deviation
#         for each measurement
featuresDF<-read.table("UCI HAR Dataset/features.txt")
# str(featuresDF)
# head(featuresDF,20)
mean_or_std<-grep("[Mm]ean\\(|[Ss]td\\(",featuresDF[,2])
# featuresDF[mean_or_std,]
mergedDF<-mergedDF[,mean_or_std]
# dim(mergedDF)
#   should be; 10299 66

# step3.Uses descriptive activity names to name 
#                    the activities in the data set
labelsDF<-read.table("UCI HAR Dataset/activity_labels.txt")
# print(labelsDF)
test_labelsDF<-read.table("UCI HAR Dataset/test/y_test.txt")
# str(test_labelsDF)
train_labelsDF<-read.table("UCI HAR Dataset/train/y_train.txt")
# str(train_labelsDF)
merged_labelsDF<-rbind(test_labelsDF,train_labelsDF)
# head(merged_labelsDF)
# dim(merged_labelsDF)
#   should be: 10299 1

merged_labelsDF[,1]<-labelsDF[merged_labelsDF[,1],2]
# head(merged_labelsDF)
# dim(merged_labelsDF)
#   should be: 10299 1

mergedDF<-cbind(merged_labelsDF,mergedDF)
# str(mergedDF)
# dim(mergedDF)
#   should be; 10299 67
#

### step4 4.Appropriately labels the data set 
#             with descriptive variable names
names(mergedDF)[1]<-"activity"
names(mergedDF)[2:67]<-as.character(featuresDF[mean_or_std,2])
str(mergedDF)

### step5. From the data set in step 4, 
#          creates a second, independent tidy data set 
#          with the average of each variable 
#          for each activity and each subject.
test_subjectsDF<-read.table("UCI HAR Dataset/test/subject_test.txt")
train_subjectsDF<-read.table("UCI HAR Dataset/train/subject_train.txt")
merged_subjectsDF<-rbind(test_subjectsDF,train_subjectsDF)
names(merged_subjectsDF)[1]<-"subject"
# str(merged_subjectsDF)
# dim(merged_subjectsDF)
#  should be; 10299 1

mergedDF<-cbind(mergedDF$activity,merged_subjectsDF,mergedDF[,2:67])
names(mergedDF)[1]<-"activity"
# str(mergedDF)
# dim(mergedDF)
#   should be; 10299 68
# length(unique(mergedDF$activity))
#   should be; 6
# length(unique(mergedDF$subject))
#   should be; 30

averageDF <- mergedDF %>% 
             group_by(activity,subject) %>%
             #summarise_each(funs(mean),3:68)
             #summarise_each(funs(mean))
             summarize_each(list(mean = mean)) %>%
             as.data.frame()
             
# dim(averageDF)
#   should be; 180 68

# head(averageDF)
write.table(averageDF,file="average_data.txt",row.names=FALSE)
# a1<-read.table("average_data.txt",header=TRUE)
