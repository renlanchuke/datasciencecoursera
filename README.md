#Getting and Cleaning Data Course Project
###First Loading data from the file
	X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
	.....................................................
	features<-read.table("./UCI HAR Dataset/features.txt")

###Merges the training and the test sets as X_data,y_label,subjects,
###using rbind() function
X_data<-rbind(X_test,X_train)
	y_label<-rbind(y_test,y_train)
subjects<-rbind(suject_test,suject_train)

##Extracts only the measurements on the mean and standard deviation for ##each ###measurement.Apply the regular expresion (.*)(mean|std)(.*) to 
###select the the variable which represnets the mean and standard deviation
	mean_std_select<-grep("(.*)(mean|std)(.*)",features[,2])
	X_data<-X_data[,mean_std_select]

###labels the data set with descriptive variable names
	subfeatures<-features[mean_std_select,2]
###Modify the features name to be qualified variable names
	subfeatures<-sub("-","_",subfeatures)
	subfeatures<-sub("-","_",subfeatures)
	subfeatures<-sub("\\(\\)","",subfeatures)
###Give each row a Appropriately name
	names(X_data)<-subfeatures
	..............................
	names(subjects)<-"subjects"

###Uses descriptive activity names to name the activities in the data set
	y_label<-sapply(y_label,function(e) activities[e,2])

###combine X_data, y_label, subjects as one data, act_measured_data
	act_measured_data<-cbind(subjects,X_data,y_label)

###Sove average of each variable for each activity and each subject
###fist split the data frame by activities or subjects
	sp_activities_data<-	split(act_measured_data[,subfeatures],act_measured_data$activities)
	sp_subjects_data<-	split(act_measured_data[,subfeatures],act_measured_data$subjects)

###Solve the average of the every columns in the splited data frame
	ave_activities<-sapply(sp_activities_data,function(x)	{colMeans(x[,subfeatures])})
	ave_subjects<-sapply(sp_subjects_data,function(x)	{colMeans(x[,subfeatures])})

###write the data in txt files
	write.table(ave_data,"./average_data.txt",row.names = FALSE)
