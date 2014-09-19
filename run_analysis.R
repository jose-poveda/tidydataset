train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "")
test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "")
allt <- rbind(train, test)
#Now we read the features text file and locate the "mean" and "std" variables
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
i <- grep("mean\\(\\)|std", features$V2)
library(dplyr)
#Subsetting and changing the variable names
names(allt) <- features$V2
suball <- select(allt, i)
#Adding the identifiers for the subjects and the different activities
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "")
subject <- rbind(subjecttrain, subjecttest)
names(subject) <- "SubjectID"
activitytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", sep = "")
activitytest <- read.table("./UCI HAR Dataset/test/y_test.txt", sep = "")
activity <- rbind(actsubjactvitytrain, activitytest)
names(activity) <- "Activities"
#Binding Activities and ID's together
subjact <- cbind(subject, activity)
#Using names easier to search for
labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
names(labels)[1] <- "Activities"
subjact <- inner_join(subjact, labels, by = 'Activities')
subjact <- select(subjact, c(1, 3))
suball <- cbind(subjact, suball)
#Now it's time to change the variable names with easier to identify names.
names(suball) <- gsub("\\(\\)", "", names(suball))
names(suball) <- gsub("^t", "Time", names(suball))
names(suball) <- gsub("^f", "Frequency", names(suball))
names(suball) <- gsub("Acc", "Accelerometer", names(suball))
names(suball) <- gsub("Gyro", "Gyroscope", names(suball))
names(suball) <- gsub("Mag", "Magnitude", names(suball))
names(suball) <- gsub("(Body){2}", "Body", names(suball))
names(suball) <- gsub("-std", "Standarddeviation", names(suball))
names(suball) <- gsub("-mean", "Mean", names(suball))
names(suball) <- gsub("-", "", names(suball))
#Creating a new data set to perform the tidying
subtidy <- suball
library(tidyr)
#Doing tidying, first, readying up the names to use tidyr
names(subtidy) <- gsub("Time", "Time_", names(subtidy))
names(subtidy) <- gsub("Frequency", "Frequency_", names(subtidy))
names(subtidy) <- gsub("Body", "Body_", names(subtidy))
names(subtidy) <- gsub("Gravity", "Gravity_", names(subtidy))
names(subtidy) <- gsub("Accelerometer", "Accelerometer_", names(subtidy))
names(subtidy) <- gsub("Gyroscope", "Gyroscope_", names(subtidy))
names(subtidy) <- gsub("Mean", "Mean_", names(subtidy))
names(subtidy) <- gsub("Standarddeviation", "Standarddeviation_", names(subtidy))
names(subtidy) <- gsub("Jerk", "Jerk_", names(subtidy))
names(subtidy) <- gsub("Magnitude", "Magnitude_", names(subtidy))
names(subtidy) <- gsub("_Mean_X", "_X_Mean", names(subtidy))
names(subtidy) <- gsub("_Mean_Y", "_Y_Mean", names(subtidy))
names(subtidy) <- gsub("_Mean_Z", "_Z_Mean", names(subtidy))
names(subtidy) <- gsub("_Standarddeviation_X", "_X_Standarddeviation", names(subtidy))
names(subtidy) <- gsub("_Standarddeviation_Y", "_Y_Standarddeviation", names(subtidy))
names(subtidy) <- gsub("_Standarddeviation_Z", "_Z_Standarddeviation", names(subtidy))
names(subtidy) <- gsub("\\_$", "", names(subtidy))
names(subtidy) <- gsub("e_X", "e_No_X", names(subtidy))
names(subtidy) <- gsub("e_Y", "e_No_Y", names(subtidy))
names(subtidy) <- gsub("e_Z", "e_No_Z", names(subtidy))
names(subtidy) <- gsub("r_X", "r_No_X", names(subtidy))
names(subtidy) <- gsub("r_Y", "r_No_Y", names(subtidy))
names(subtidy) <- gsub("r_Z", "r_No_Z", names(subtidy))
names(subtidy) <- gsub("e_Ma", "e_No_Ma", names(subtidy))
names(subtidy) <- gsub("r_Ma", "r_No_Ma", names(subtidy))
names(subtidy) <- gsub("Jerk", "Yes", names(subtidy))
#Making sure there are 6 variables in the names, first two don't need to have "_"
grep("(.*\\_){5}", names(subtidynum))
#Using tidyr to put variables as columns
subtidy <- gather(subtidynum, domain, Measure, -SubjectID, -Activities)
subtidy <- separate(subtidynum, domain, c("Domain", "Acceleration", "Device", "Jerk", "Axis", "Statistic"))
#Summarizing the info doing reshaping.
library(reshape2)
meltsubtidy <- melt(subtidy, id.vars = c("SubjectID", "Activities"), measure.vars = "Measure", na.rm = TRUE)
sumtidy <- dcast(meltsubtidy, SubjectID + Activities ~ variable, mean)
#Now we have to write this table so everyone is able to read it
write.table(sumtidy, "tidy_data.txt", row.names = FALSE)