
setwd("D:/Coursera/DataScientist/3. Getting and Cleaning Data/project")

library(dplyr)
library(reshape2)

## read in a vector with features, the separator between rows is the newline character (not displayed by notepad)

features <- scan("features.txt", what = "character", sep = "\n")

## read in the labels for each label reference.

activity_labels <- scan("activity_labels.txt",what = "character", sep = "\n")

## split into two columns (reference and label)

activity_labels <- cbind(substring(activity_labels,1,1),substring(activity_labels,2))
activity_labels <- as.data.frame(activity_labels)
names(activity_labels) <- c("reference", "label")

######################################################################################################################
##
##          read TEST DATA
##
######################################################################################################################


## read in a dataframe with the test data

testdata <- read.table("./test/X_test.txt")

## give the testdata dataset meaningful column names, assuming columns are in the same order as in the features vector.

names(testdata) <- features

## Before continuing, for space considerations, I will keep only those with either mean() or std(). 
## The backslash has been used to include the regular expression for (, and thus excluding meanFreq().

testdata <- dplyr::select(testdata, grep('-mean\\(|-std\\(', colnames(testdata)))

## Remove the characters in front (number and space) of the columnnames.

names(testdata) <- substring(colnames(testdata),first=regexpr(' ',colnames(testdata))+1)

## read in the subject references for each record

subject <- as.numeric(scan("./test/subject_test.txt"))

## read in the label references for each record. These are integers read as characters so subsequently coerced to numbers.

activity <- as.numeric(scan("./test/y_test.txt"))

## merge the testdata with the corresponding identificators (subject and activity), 
## assuming the order of the observations in the three datasets is identical, 
## i.e. row x references the same observation in the testdata, in the subject vector and in the activity vector.

testdata <- cbind(subject,activity,testdata)


######################################################################################################################
##
##          read TRAIN DATA (identical as for TEST DATA)
##
######################################################################################################################

traindata <- read.table("./train/X_train.txt")

names(traindata) <- features

traindata <- dplyr::select(traindata, grep('-mean\\(|-std\\(', colnames(traindata)))

names(traindata) <- substring(colnames(traindata),first=regexpr(' ',colnames(traindata))+1)

subject <- as.numeric(scan("./train/subject_train.txt"))

activity <- as.numeric(scan("./train/y_train.txt"))

traindata <- cbind(subject,activity,traindata)

######################################################################################################################
##
##          MERGE both 
##
######################################################################################################################

## both datasets had been separated earlier, so originally they come from the same dataset and can thus be recombined.

Mydata = rbind(testdata,traindata)

rm(traindata)
rm(testdata)

## apply the labels to the dataset, i.e. attach the activity labels to their references in the dataset.

Mydata$activity <- factor(Mydata$activity,levels = activity_labels$reference, labels = activity_labels$label)

######################################################################################################################
##
##          TIDY
##
######################################################################################################################

## tidy dataset with average for each subject and each activity

## here, in my opinion, several variables are "hidden" in each measure : for example tBodyAcc-mean()-X represents in fact : 
## the mean measure in the time-domain of the variable BodyAcc along the X-axis.
## I have thus chosen to separate those "variables" in order to enable easier access to measurement of interest.

tidy<-melt(Mydata,id=c("subject","activity" ))

tidy <- mutate(tidy, basevar = substring(variable,first = regexpr(' ',variable)+3,last = regexpr('-',variable)-1), 
                     domain = substring(variable,first = regexpr(' ',variable)+1,regexpr(' ',variable)+2), 
                     remainder = substring(variable, first = regexpr('-',variable)+1))

tidy <- mutate(tidy,measure = substring(remainder,1,last = regexpr('\\(',remainder)-1), 
                   axis = substring(remainder,first = 1+regexpr('-',remainder),last=1+regexpr('-',remainder)))

tidy <-select(tidy,subject,activity,basevar,domain,axis,measure,value)

## now let's apply some labels

tidy$domain <-factor(tidy$domain,levels = c("t","f"), labels = c("time","frequency") )

## option 1 : a rather narrow tidy dataset (only the mean and standard deviations are on the same row)
## the measure variables have been decomposed into 3 columns : base variable, domain and axis

tidynarrow <- dcast(tidy,subject+activity+basevar+domain+axis~measure,mean)

##   subjectactivity  basevar    domain axis        mean         std
## 1       1  WALKING BodyAcc      time    X  0.27733076 -0.28374026
## 2       1  WALKING BodyAcc      time    Y -0.01738382  0.11446134
## 3       1  WALKING BodyAcc      time    Z -0.11114810 -0.26002790
## 4       1  WALKING BodyAcc frequency    X -0.20279431 -0.31913472
## 5       1  WALKING BodyAcc frequency    Y  0.08971273  0.05604001
## 6       1  WALKING BodyAcc frequency    Z -0.33156012 -0.27968675

## option 2 : the wide version of the tidy dataset : only activity and subject have been retained as fixed variables.

tidywide <- dcast(tidy,subject+activity~domain + basevar + axis + measure,mean)

##   subject            activity time_BodyAcc_X_mean time_BodyAcc_X_std time_BodyAcc_Y_mean time_BodyAcc_Y_std 
## 1       1             WALKING           0.2773308        -0.28374026        -0.017383819        0.114461337       
## 2       1    WALKING_UPSTAIRS           0.2554617        -0.35470803        -0.023953149       -0.002320265      
## 3       1  WALKING_DOWNSTAIRS           0.2891883         0.03003534        -0.009918505       -0.031935943       

## option 3 : the narrow version using summarize as an alternative

## tidy <-group_by(tidy,subject,activity,basevar,domain,measure,axis)

## smalltidy<-summarize(tidy,mean=mean(value))




