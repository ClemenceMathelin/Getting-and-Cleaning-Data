#Run the run_analysis.R

#1 - Get the data from the web
rawData <- "./rawData"
data <- "./data"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"


if (!file.exists(rawData)) {
  dir.create(rawData)
  download.file(fileURL, destfile = "./rawData/rawData.zip")
}
if (!file.exists(data)) {
  dir.create(data)
  unzip(zipfile = "rawData/rawData.zip", exdir = "./data")
}



#2 - Merge data sets (train and test sets)
# train data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
s_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# test data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
s_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Activity labels
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

# Assigning column names
features <- read.table("./data/UCI HAR Dataset/features.txt")
colnames(x_train) <- features[,2]
colnames(y_train) <-"activityId"
colnames(s_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(s_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging {train, test} data
mrg_train <- cbind(y_train, s_train, x_train)
mrg_test <- cbind(y_test, s_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)
dim(setAllInOne)


#3 - Extract measurements on the mean and std deviation for earch measurement

colNames <- colnames(setAllInOne)
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)


# 4 - Use descriptive activity names and labels
#Already done previously (like "activityId")



# 5 - Create a tidy data set

secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
secTidySet
