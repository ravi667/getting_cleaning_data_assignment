## Data source for the project is:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## This R script includes the process of reading the raw datasets into R and creating a tidy dataset.
## The following are the steps involved in the process of creating a tidy dataset.

## STEP 1: Merging the training and the test sets to create one dataset.
X_train<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt") 
X_test<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")    
X_Values_data<-rbind(X_train,X_test)                                                            

Y_train<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
Y_test<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
Y_Values_data<-rbind(Y_train,Y_test)                                                            

Subject_train<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
Subject_test<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
Subject_ID<-rbind(Subject_train,Subject_test)                                                   

## STEP 2: Extracts the measurements on the mean and standard deviation for each variable
features<-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")     
features_refined<-grep("-mean\\(\\)|-std\\(\\)",features[,2])                                   
X_Values_data<- X_Values_data[,features_refined]                                                
names(X_Values_data) <- features[features_refined, 2]                                            
names(X_Values_data) <- gsub("\\(|\\)", "", names(X_Values_data))                               
names(X_Values_data) <- tolower(names(X_Values_data))                                           

## STEP 3: Uses descriptive activity names to name the activities in the data set
activity <-read.table("./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
activity[,2]<-gsub("_","",tolower(as.character(activity[,2])))                                     
Y_Values_data[,1]<-activity[Y_Values_data[,1],2]                                                   
names(Y_Values_data)<-"activity"

## STEP 4: Appropriately labels the data set with descriptive activity names.
names(Subject_ID)<-"subject"                                                                    
clean_data<-cbind(Subject_ID,Y_Values_data,X_Values_data)                                       
write.table(clean_data,"clean_data.txt")                                                        

## STEP 5: Creates a Second independent tidy data set with the average of each variable for each activity and each subject.
unique_Subjects<-unique(Subject_ID)[,1]                                                         
num_of_Subjects<-length(unique(Subject_ID)[,1])                                                 
num_of_Activity<-length(activity[,1])                                                           
num_of_Cols<-dim(clean_data)[2]                                                                 
result<-clean_data[1:(num_of_Subjects*num_of_Activity), ]                                        
write.table(result, "data_set_with_the_averages.txt",row.names=FALSE)                           
                                                                                                
##### E    N   D #####
