MODIFICATIONS

The original data was transformed by:

1. Merge the training and the test sets to create one data set.
2. Extract the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

About R Script 
File with R code "run_analysis.R" performs those previous 5 steps.

DESCRIPTION

Id variables 
The first two columns - Subject and Activity - are Identifiers: 
subjectId: the ID of the Subject 
activityId: the Name of the Activity performed by the subject when measurements were taken

Measurements 
All the remaining variables are the calculatd means and standard deviations of these sets of data. 
Some of these measurements: tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ tBodyAccStdX tBodyAccStdY tBodyAccStdZ ...
