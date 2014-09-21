UCI_HAR_Tidy_Data
=================

Course Project for Coursera Getting &amp; Cleaning Data

## Purpose
This repository was created to meet the requirements of the Course Project for Coursera's 'Getting & Cleaning Data' course.
The project entails obtaining, understanding, cleaning, and transforming data.

## Getting Ready
  1.  Download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to a directory named “UCI HAR Dataset.”
  2.  Save the run_analysis.R file in the repository to the top level of this directory.
  3.  Set your working directory to ‘UCI HAR Dataset’.

## What run_analysis.R Does
  1.  Reads in the training data, training activity ids, training subject ids and binds them to a single dataframe named "traingroup."
  2.  Reads in the test data, test activity ids, test subject ids and binds them to a single dataframe named "testgroup."
  3.  Combines these two datasets into one named "allgroup."
  4.  Adds descriptive column names.
  5.  Subsets the "allgroup" data to include only measurements of mean and standard deviation values (33 of each) into a new dataframe named "mydata."
  6.  Updates the activity ids to be descriptive names (Walking, Walking Upstairs, Walking Downstairs, Standing, Sitting, Laying).
  7.  Calculates the average measurement for each subject for the different measures included in "mydata" and stores them in a table named "subjectmeans."
  8.  Writes "subjectmeans" data to a file (without row names) in your working directory.  This file is named "HAR_SubjectMeans.txt."
  9.  Optionally, two lines of code at the end of the run_analysis.R file can be uncommented to create a file with descriptive names for the "subjectmeans" measures.
