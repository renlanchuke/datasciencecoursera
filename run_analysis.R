#Loading data
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
suject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
suject_train<-read.table("./UCI HAR Dataset/train//subject_train.txt")
activities<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")

#Merges the training and the test sets as X_data,y_label,subjects
X_data<-rbind(X_test,X_train)
y_label<-rbind(y_test,y_train)
subjects<-rbind(suject_test,suject_train)

#Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std_select<-grep("(.*)(mean|std)(.*)",features[,2])
X_data<-X_data[,mean_std_select]

#labels the data set with descriptive variable names
subfeatures<-features[mean_std_select,2]
subfeatures<-sub("-","_",subfeatures)
subfeatures<-sub("-","_",subfeatures)
subfeatures<-sub("\\(\\)","",subfeatures)

names(X_data)<-subfeatures
names(y_label)<-"activities"
names(subjects)<-"subjects"

#Uses descriptive activity names to name the activities in the data set
y_label<-sapply(y_label,function(e) activities[e,2])

#combine X_data, y_label, subjects as one data, act_measured_data
act_measured_data<-cbind(subjects,X_data,y_label)

#sove average of each variable for each activity and each subject
sp_activities_data<-split(act_measured_data[,subfeatures],act_measured_data$activities)
ave_activities<-sapply(sp_activities_data,function(x){colMeans(x[,subfeatures])})
sp_subjects_data<-split(act_measured_data[,subfeatures],act_measured_data$subjects)
ave_subjects<-sapply(sp_subjects_data,function(x){colMeans(x[,subfeatures])})
ave_data<-cbind(ave_activities,ave_subjects)
ave_data<-data.frame(ave_data)
ave_data<-cbind(features,ave_data)

#write the data in txt files
write.table(ave_data,"./average_data.txt",row.names = FALSE)

