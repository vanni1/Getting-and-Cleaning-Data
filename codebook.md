# CodeBook - Tidy narrow dataset

## Data Set Origins

The data originate from a series of experiments carried out with a group of 30 volunteers.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone.
The sensor signals (accelerometer and gyroscope) of the smartphone were captured while the persons were involved in one of those activities.
Preprocessing has been performed to remove noise, and to separate, in the case of linear acceleration (accelerometer), the gravitational from the body component.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals.
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing the associated frequency domain signals.

* [Detailed Summary](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* [Original DataSet](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )


## DataSet tidynarrow

is an aggregated dataset containing the mean of both the mean and standard deviation for each unit,
being a given base variable for a given time/frequency domain and direction for a given subject performing a given activity.

It consists of 7 variables and 5940 observations.

1. subject 
* indicates the person performing the experiment
* is an integer between 1 and 30

2. activity
* indicates the activity
* is a labeled integer (1 - WALKING, 2 - WALKING_UPSTAIRS,3 - WALKING_DOWNSTAIRS, 4 - SITTING, 5 - STANDING, 6 - LAYING)

3. basevar
* indicates the base variable
* is one of : 
  * BodyAcc 	: body linear acceleration
  * BodyAccJerk  : body linear acceleration jerk
  * BodyAccJerkMag : magnitude of body linear acceleration jerk
  * BodyAccMag : magnitude of body linear acceleration
  * BodyBodyAccJerkMag --> should be BodyAccJerkMag
  * BodyBodyGyroJerkMag --> should be BodyGyroJerkMag
  * BodyBodyGyroMag --> should be BodyGyroMag
  * BodyGyro : angular acceleration
  * BodyGyroJerk  : angular acceleration jerk
  * BodyGyroJerkMag : magnitude of angular acceleration jerk
  * BodyGyroMag : magnitude of angular acceleration
  * GravityAcc : gravity
  * GravityAccMag : gravity magnitude 

4. domain
* denotes the time or frequency domain
* is a labeled character (f=frequency;t=time) 

5.axis
* denotes the axial component of the 3 dimensional signal
* can be either x,y or z (character denoting the euclidean axis) or empty (NA)

6. mean
* values normalized and bounded within [-1,1].

7. standard deviation
* values are normalized and bounded within [-1,1].
