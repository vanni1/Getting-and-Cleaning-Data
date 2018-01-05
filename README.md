# Readme - run_analysis.R

the files presented here were written for an assignment for the "Getting and Cleaning Data" course on coursera.

* [Assignment instructions](https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project)

## Assignment Instructions

Basically it consists of creating one R script called run_analysis.R that does the following.

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement.
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## Environment

* The original dataset can be obtained [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip )
* The working directory should be set to the directory where the files have been unzipped (this is the directory containing the README file)
* The size of the dataset is about 100 Mb
* The code was run on Windows


## Transformation Steps up to step 4 of the assignment

* It uses both the 'plyr' and 'reshape2' libraries (although either one would be enough).
* It sets the working directory to where the datafiles have been unzipped.So this (the first line) should probably be adapted to run on your computer.
* It reads in the feature vector, containing the variable names (column headers) of the test and train datasets.
* It reads in the activity labels.
* It reads in the test dataset, names the columns, and retains only the mean and standard deviation measures.
* It adds the subject and activity vectors to the test dataset.
* It repeats the last two steps, but now on the train dataset.
* The train and test datasets are then merged (they have the same structure so can they can be simply row-bound)
* It labels the activity variable.
* Mydata is the dataset as defined in step 4 of the assignment

## Creating the Tidy dataset (last transformation steps)

I refer to the Hadley Wickams [Tidy Data article] (http://vita.had.co.nz/papers/tidy-data.pdf) for the framework used to define tidy data.
Several approaches may in fact be taken, to tidy the given dataset, 
and where to draw the line between an atribute and a unit can be not as clearcut as one would wish for,
and may depend on the subsequent analysis of the data.

In our case the subject and activity are clearly variables (fixed variables or dimensions).
The mean and standard deviation are both a (kind of) measure of the same underlying attributes,
and should as such be defined as variables as well.

The other variables are less clear and will depend on the analysis one wishes to make.
I have chosen to present both options here : 
* a narrow tidy dataset (where variablenames have been decomposed into several columns)
* a wide tidy dateset (where only the subject and the activity have been kept as dimensions)

datasteps : 
* melt Mydata from the previous steps, keeping only subject and activity as id variables.
* decompose the variable name into its various constituents
* apply labels to the domain variable
* option 1 : create a narrow tidy dataset by keeping only mean and std as 'measures'
* option 2 : create a wide tidy dataset by keeping only subject and activity as 'dimensions'
