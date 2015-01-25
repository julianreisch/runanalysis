run_analysis <- function(){
  #Downloads and extracts the zip-file
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",dest="zip-file.zip")
  data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
  labels_test <- read.table("UCI HAR Dataset/test/y_test.txt")  
  data_train <- read.table("UCI HAR Dataset/train/X_train.txt") 
  labels_train <- read.table("UCI HAR Dataset/train/y_train.txt")
  subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt") 
  features <- read.table("UCI HAR Dataset/features.txt") 

  #Create one data frame for both test and tranining data
  data<-rbind(data_test,data_train)
  
  #Give appropriate titles
  features_vector<-as.vector(features[,2])
  colnames(data)<-features_vector
  
  #Extract the measurements on mean and standard deviation
    #Check which columns are the ones containing information about mean and std dev
    mean_logical<-grepl("mean()",colnames(data))
    std_logical<-grepl("std()",colnames(data))
    meanStd_logical<-!(mean_logical==FALSE & std_logical==FALSE)
    #return(meanStd_logical)  
  
    #Extract those columns into new data frame
    dataExtracted<-data[,meanStd_logical]
  
  #Attach Subject IDs and Label IDs
  IDs_test<-cbind(subj_test,labels_test)
  IDs_train<-cbind(subj_train,labels_train)
  IDs<-rbind(IDs_test,IDs_train)
  colnames(IDs)<-c("subject_ID","label")
  dataCompleted<-cbind(IDs,dataExtracted)
  
  #Replace label ID by name of activity
  activity_names<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LYING")
  for (i in 1:6){
    for (j in 1:nrow(dataCompleted)){
      if(dataCompleted[j,2]==i){
        dataCompleted[j,2]<-activity_names[i]
      }
    }
  }
  #Create a summary data frame
  summaryDataframeRight<-numeric()
  summaryDataframeLeft<-dataCompleted[,1:2]
  meanValue<-0
  for (k in 1:nrow(dataCompleted)){
    for (j in 3:ncol(dataCompleted)){
      meanValue<-meanValue+dataCompleted[k,j]/ncol(dataCompleted)
    }
    summaryDataframeRight[k]<-meanValue
    meanValue<-0
  }

  summaryDataframe<-cbind(summaryDataframeLeft,summaryDataframeRight)
  colnames(summaryDataframe)<-c("Subject_ID","Label","Average")
  summaryDataframe
}
