##Code Book<br>
#Course Project: Getting and Cleaning Data
<br><br>
The run_analysis function first reads the data. You need to have unzipped the folder UCI HAR Dataset in your working directory. <br>
The data frame data contains test and train data and gets titles from the data frame features.<br>
Only measurements containing information about mean and standard derivation are extracted to dataExtracted.<br>
The subject IDs and label IDs are attached using the data frames labelstest, labelstrain, subjtest and subjtrain.<br>
The label IDs are replaced by the label names.<br>
The data is summarized by creating a data frame summaryDataframe that contains the average of each variable for each activity and each subject.
