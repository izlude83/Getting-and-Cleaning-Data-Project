---
title: "Codebook for Getting and Cleaning Data Course Project"
output: html_document
---

### Introduction

This codebook describes the variables, data, and transformations used to clean up the data used for the Getting and Cleaning Data Course.


### Original Data

The original data used for this project was downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data comprises the 3-axial linear acceleration and 3-axial angular velocity of 30 volunteers who have performed six activities (walking, walking up the stairs, walking down the stairs, sitting, standing and laying) as recorded by the Samsung Galaxy SII they wore on their waist while performing the activity. The dataset has been random partitioned into 2 sets, whereby 70% of volunteers were selected for generating the training data, and the remaining for generating the test data. 

For more details on the data contained within the original data set, refer to the readme.txt file contained within the zipped file. 


### Transformations Done

The original data contained within the following files were first loaded into R and combined into a temporary dataset using mainly rbind and cbind functions:
(a) subject_test.txt
(b) subject_train.txt
(c) X_test.txt
(d) X_train.txt
(e) Y_test.txt
(f) Y_train.txt
(g) features.txt
(h) activity_labels.txt

Only the means and standard deviations (3-axial) of the various acceleration and angular velocity variables were extracted into a second temporary dataset. This reduced the total number of variables from 563 to 81.

Under this dataset, there were multiple measurements (of means and standard deviations) of each subject performing different activities. These were averaged into a third dataset. This dataset was then downloaded out into the product dataset contained within the data file "clean_data_set.txt". 


### Clean Data Set

The final dataset under clean_data_set.txt comprises 180 average measurements (for each of the 30 subjects performing each of the 6 stipulated activities) of 79 variables, for a total of 81 variables (79 + 2 denoting the subject and activity) .


### Using Clean Data Set

The following command can be used to read the cleaned dataset contained under clean_data_set.txt.

cleandata <- read.table("clean_data_set.txt", header = TRUE)