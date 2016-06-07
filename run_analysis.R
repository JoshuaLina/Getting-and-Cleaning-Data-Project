## Getting and Cleaning Data: Course Project
## By Olinto Linares-Pedomo
## Coursera

## Step 1. Merges the training and the test sets to create one data set called datamerged.
getwd()
setwd("C:/Users/ojlinare/Desktop/DataScience/Getting and Cleaning Data/Final Poject")
getwd()

   ## calling into r each variable
    test.labels <- read.table("test/y_test.txt", col.names="label")
    test.labels
    test.subjects <- read.table("test/subject_test.txt", col.names="subject")
    test.subjects
    test.data <- read.table("test/X_test.txt")
    test.data
    train.labels <- read.table("train/y_train.txt", col.names="label")
    train.labels
    train.subjects <- read.table("train/subject_train.txt", col.names="subject")
    train.subjects
    train.data <- read.table("train/X_train.txt")
    train.data

# putting together all variables to merged in the data sed called datamerged
datamerged <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))

datamerged



## step 2: Extracts only the measurements on the mean and standard deviation for each mesure on the datamerged file (step 1)


features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE);
features

# only retain features of mean and standard deviation
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]
features.mean.std

# select only the means and standard deviations from data, with increment by 2 ,data has subjects and labels in the beginning
data.mean.std <- datamerged[, c(1, 2, features.mean.std$V1+2)]

data.mean.std


## Step 3: Uses describe activity names to name the activites in teh data set
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE); ## Reading the lebels activities
data.mean.std$label <- labels[data.mean.std$label, 2]; ## replacing labels

data.mean.std$label


## step 4 Apropiately labels the data set with descriptive vaiable names
# first make a list of the current column names and feature names
good.colnames <- c("subject", "label", features.mean.std$V2)
# then tidy that list
# by removing every non-alphabetic character and converting to lowercase
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
# then use the list as column names for data
colnames(data.mean.std) <- good.colnames



## Step 5 From data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],by=list(subject = data.mean.std$subject, 
                               label = data.mean.std$label),mean)


tidy<-write.table(format(aggr.data, scientific=T), "tidydata_final_project.txt",
            row.names=FALSE, col.names=FALSE, quote=2)
tidy

##

