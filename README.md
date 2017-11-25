---
title: "Readme File for Getting and Cleaning Data Course Project"
output: html_document
---

### Introduction

This file provides an explanation of the work done under this project.

### Step 0 - Load all data files

The following code loads the various data files downloaded into R. 

```{r}
s_test <- read.table("subject_test.txt")
s_train <- read.table("subject_train.txt")
x_test <- read.table("X_test.txt")
x_train <- read.table("X_train.txt")
y_test <- read.table("Y_test.txt")
y_train <- read.table("Y_train.txt")
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")
```

### Step 1 - Merge data to form one dataset 

The training and test files were first combined using rbind.

```{r}
x_total <- rbind(x_train, x_test)
remove(x_train, x_test)
y_total <- rbind(y_train, y_test)
remove(y_train, y_test)
s_total <- rbind(s_train, s_test)
remove(s_train, s_test)
```

Next, the header of the x table was populated using the features table which contains the descriptions of the different variables measured.

```{r}
names(x_total) <- features[,2]
remove (features)
```

The y table contains integers 1 to 6 which signify each of the activities which is stored under the activity table. These integers were replaced by the descriptions of the activities using the below code. 

```{r}
y_total$Activity <- activity[match(y_total[,1],activity[,1]),2]
remove(activity)
```

Lastly, the three data tables (s, y and x) were combined using cbind into dataset d1. The headers of the variables under s and y were also renamed as "Subject" and "Activity" respectively (the variables under x have been populated earlier above).

```{r}
names(s_total) <- "Subject"
d1 <- cbind(s_total, y_total[,2], x_total)
remove(s_total, x_total, y_total)
names(d1)[2] <- "Activity"
```

### Step 2 - Extract only subject, activity and mean/std columns from dataset

Per project instructions, only mean and standard variables are to be extracted. The following code extracts these variables, together with subject and activity, into dataset d2. 

```{r}
coltoget = c(1,2, grep("mean", names(d1)), grep("std", names(d1)))
coltoget <- sort(coltoget)
d2 <- d1[, coltoget]
remove (coltoget)
```

### Step 3 - Use descriptive activity names to name the activities in the data set 

This has been done as part of Step 1 earlier.


### Step 4 - Appropriately label the data set with descriptive variable names 

This has also been done as part of Step 1 earlier.


### Step 5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

The following code averages each variable grouped by subject and activity into a new dataset d3 which is then extracted into a datafile "clean_data_set.txt".

```{r}
library(dplyr)
d3 <- d2 %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(d3, file = "clean_data_set.txt", row.name=FALSE)
remove(d1, d2, d3)
```
