# Getting-and-Cleaning-Data
The data set in this project is about sporting data science using the sensors in smartphone. 
These experiments have been over a group of 30 subjects. Each person performace six activities
(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) with a smartphone over theirs.

 In the first fase script get a data set to repository: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The file is opening and change a work directory into the data set directory

After, is opening the principal files "X_[phase]" where phase are :test or train 

The labels of data set were taken in features file, thas informatios is procesing to get a appropriately labels (completed point 4 request)

To get a tidy data, the informatios of subjects and activities were get to  files "subject_[phase]"   where phase are :test or train 
and were labeling there information and finally are Merges in a table (tidy_data) to processing the requestment: mean and standar deviations

The tb_4 table is a indepedent tidy data set to point number 5, with average for each activity and each subject.


