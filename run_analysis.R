# Step 0 - Load all data files
s_test <- read.table("subject_test.txt")
s_train <- read.table("subject_train.txt")
x_test <- read.table("X_test.txt")
x_train <- read.table("X_train.txt")
y_test <- read.table("Y_test.txt")
y_train <- read.table("Y_train.txt")
features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")

# Step 1 - Merge data to form one dataset (we will name the merged dataset d1)
x_total <- rbind(x_train, x_test)
remove(x_train, x_test)
y_total <- rbind(y_train, y_test)
remove(y_train, y_test)
s_total <- rbind(s_train, s_test)
remove(s_train, s_test)
names(x_total) <- features[,2]
remove (features)
y_total$Activity <- activity[match(y_total[,1],activity[,1]),2]
remove(activity)
names(s_total) <- "Subject"
d1 <- cbind(s_total, y_total[,2], x_total)
remove(s_total, x_total, y_total)
names(d1)[2] <- "Activity"

# Step 2 - Extract only subject, activity and mean/std columns from dataset (we will name this dataset d2)
coltoget = c(1,2, grep("mean", names(d1)), grep("std", names(d1)))
coltoget <- sort(coltoget)
d2 <- d1[, coltoget]
remove (coltoget)

# Step 3 - Use descriptive activity names to name the activities in the data set (we have done this in Step 1)

# Step 4 - Appropriately label the data set with descriptive variable names (we have also done this in Step 1)

# Step 5 - From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject (we will name this dataset d3 and write the file into clean_data_set.txt)
library(dplyr)
d3 <- d2 %>% group_by(Subject, Activity) %>% summarise_each(funs(mean))
write.table(d3, file = "clean_data_set.txt", row.name=FALSE)
remove(d1, d2, d3)