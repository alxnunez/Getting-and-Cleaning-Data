library(dplyr)
library(reshape2)
word_directory=getwd();
  
if(!file.exists("UCI HAR Dataset/")) {
  url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url,destfile ="Dataset.zip")
  unzip("Dataset.zip")
}

setwd("UCI HAR Dataset/")

#reading data files
#  get info to 9 subject in test fase 
x_test<-read.table("test/X_test.txt")
# get info to 21 subject in trainig fase
x_train<-read.table("train/X_train.txt")

prenames<-read.table("features.txt")
prenames2<-as.character(prenames$V2)
prenames2<-make.names(prenames2,unique=TRUE)
prenames2<-sub("\\.{2,3}","\\.",prenames2);prenames2<-sub("\\.$","",prenames2)
names(x_test)<-prenames2
names(x_train)<-prenames2

#subject to test (9 subject)
subject<-read.table("test/subject_test.txt")
subject_train<-read.table("train/subject_train.txt")

#labeling to id subject
names(subject)<-"subject"
names(subject_train)<-"subject"

#set to activities in test fase (6 types to activies)"
y_test<-read.table("test/y_test.txt")

#set to activities in training fase (6 types to activies)"
y_train<-read.table("train/y_train.txt")
#labeling to id subject
names(y_test)<-"activity"
names(y_train)<-"activity"

#names to activities
l_activities<-read.table("activity_labels.txt")

tb_value<-rbind(x_test,x_train)

# Extracts the measurements on the mean (tb_mean) and standard deviation (tb_std) for each measurement.
#  standar deviations values
tb_std <- sapply(tb_value,sd)
# averaga values
tb_mean<- sapply(tb_value,mean)

#merge tables subject, activities and measurments

tb_test<-cbind(subject,y_test,x_test)
tb_train<-cbind(subject_train,y_train,x_train)

tb_full<-rbind(tb_test,tb_train)

# including descriptive activity names to name the activities in the data set
tb_full<-mutate(tb_full,description=ordered(tb_full$activity,levels=c(4,6,5,2,3,1),labels=levels(l_activities$V2)))


# tb_4 is a independent tidy data set with the average of each variable
#for each activity and each subject.
group_sub_act<-group_by(tb_full,subject,activity)
tb_4<-sapply(group_sub_act,mean)
write.table(tb_4,file="tb_4.txt",row.names=FALSE)

 setwd(word_directory)




