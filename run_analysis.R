##S1. Read files
train.x <- read.table("../UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("../UCI HAR Dataset/train/y_train.txt")
train.subject <-read.table("../UCI HAR Dataset/train/subject_train.txt")
test.x <- read.table("../UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("../UCI HAR Dataset/test/y_test.txt")
test.subject <-read.table("../UCI HAR Dataset/test/subject_test.txt")

##S2. Show data in differet txt files
head(train.x);
head(train.y);
head(train.subject);
head(test.x);
head(test.y);
head(test.subject);

##S3. To create one dataset, merge the training and test datasets
trainData <- cbind(train.subject, train.y, train.x)
testData <- cbind(test.subject, test.y, test.x)
completeData <- rbind(trainData, testData)

##S4. For each measurement, extract mean and standard deviation

## step 1: load feature name into R
featureNames <- read.table("../UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)

## step 2: extract mean and standard deviation for each measurements
featureIndexes <- grep(("mean\\(\\)|std\\(\\)"), featureNames[,2])

## step3: label the data set with appropriate variable names
names(featureIndexes) <- featureNames [featureIndexes,2]
names(featureIndexes) <- gsub("\\()", "", names(featureIndexes))
names(featureIndexes) <- gsub("-mean", "Mean", names(featureIndexes))
names(featureIndexes) <- gsub("-std", "Std", names(featureIndexes))

finalData <- completeData[, c(1, 2, featureIndexes+2)]
names(finalData) <- c("subject", "activity", names(featureIndexes))

##S5. Uses descriptive activity names for the activities in the data set &
##S6. Label the data set using descriptive variable names.

## step 1: load activity data into R
activityNames <- read.table("../UCI HAR Dataset/activity_labels.txt")

## step 2: use activity names instead of 1 to 6 
finalData$activity <- factor(finalData$activity, levels = activityNames[,1], labels = activityNames[,2])

##S7. From the data set in step 4, creates a second, independent tidy data set with the average of each 
   ## variable for each activity and each subject.
library(magrittr)
library(dplyr)
groupData <- finalData %>% group_by(subject, activity) %>% summarise_all(funs(mean))
head(groupData)

##S8. Write the output to a text file
write.table(groupData, "../UCI HAR Dataset/TidyData.txt", row.names = FALSE)
