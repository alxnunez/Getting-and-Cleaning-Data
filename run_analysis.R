library(dplyr)
 
  
if(!file.exists("Dataset.zip")) {
  url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,destfile ="Dataset.zip")
  unzip("Dataset.zip")
}



#reading data files

# get info in test phase
# data subject (test)
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
#get to activities in test fase (6 types to activies)"
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
# subject to test (9 subject)
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")


# get info in trainig phase  
# to 21 subject 
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
# subject to trainig phase (9 subject)
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt",)
#set to activities in training phase (6 types to activies)"
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

#data 
tb_values<-rbind(x_test,x_train)
tb_labels<-rbind(y_test,y_train)
tb_subjects<-rbind(subject_test,subject_train)

features<-read.table("UCI HAR Dataset/features.txt")

mean_std_features<-grepl("(-std\\(\\)|-mean\\(\\))",features$V2)

prenames<-features[mean_std_features==TRUE,2]
prenames<-sub("\\.{2,3}","\\_",prenames);
prenames<-sub("\\.$","",prenames);
prenames<-gsub("(\\(|\\)|\\-)","",prenames)


tidy_data<-tb_values[,mean_std_features==TRUE]


#names to activities
activities_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

activity<-as.factor(tb_labels$V1)
levels(activity)<-activities_labels$V2
subject<-as.factor(tb_subjects$V1)

tidy_data<-cbind(subject,activity,tidy_data)
names(tidy_data)<-c("subject","activity",tolower(prenames))

td_4<-aggregate(by=group_by(tidy_data,subject,activity),x=tidy_data,FUN=mean)

write.table(td_4,file="averages.txt",row.names=FALSE)





