### "GETTING AND CLEANING DATA" Program Assignement

    # Set working directory for running this project:
    setwd(dir = "./R/Getting and Cleaning Data/Course project")

    # Download data:
    if (!file.exists("./Dataset.zip")){
    download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./Dataset.zip")
    }

    # Unzip zipfile:
    unzip(zipfile = "./Dataset.zip")

    # Delete .zip file:
    file.remove("./Dataset.zip")

    # Rename data folder:
    file.rename(from = "UCI HAR Dataset", to = "Dataset")

    # Set working directory:
    setwd(dir = "./Dataset")

    # Load packages:
    install.packages("lazyeval")
    require(package = data.table)
    require(package = dplyr)

## 1-) Merge the training and the test sets to create one data set

    # Read data:
    train <- read.table("./train/X_train.txt")
    train_subj <- read.table("./train/subject_train.txt")
    train_lab <- read.table("./train/y_train.txt")
    test <- read.table("./test/X_test.txt")
    test_subj <- read.table("./test/subject_test.txt")
    test_lab <- read.table("./test/y_test.txt")

    # Re-set column names on 1-variable data sets ("label" and "subject"):
    setnames(x = train_lab, old = names(train_lab), new = "act")
    setnames(x = test_lab, old = names(test_lab), new = "act")
    setnames(x = train_subj, old = names(train_subj), new = "subj")
    setnames(x = test_subj, old = names(test_subj), new = "subj")

    # Create a "data_type" column in "train" and "test" datasets:
    train$data_type <- "train"
    test$data_type <- "test"

    # Join "train" and "test" data in the same data frame:
    dataset <- rbind(train, test)
    subj <- rbind(train_subj, test_subj)
    lab <- rbind(train_lab, test_lab)

    # Join data frames:
    dataset <- cbind(subj, lab, dataset)

    # Re-order columns in "train" and "test" tables, in order to put "data_type" as the first column:
    dataset <- dataset[c(564, 1:563)]

    # Remove intermediate tables:
    rm(lab)
    rm(train_lab)
    rm(test_lab)
    rm(subj)
    rm(train_subj)
    rm(test_subj)
    rm(train)
    rm(test)

    # Viewing the resulting data set:
    # View(dataset)

## 2-) Extracts only the measurements on the mean and standard deviation for each measurement

    # Read features data:
    features <- read.table("./features.txt")
    
    # Filter measurements containing "mean" or "std" on "features" data frame's 2nd column:
    u_std_indexes <- grep(pattern = "mean\\(\\)|std\\(\\)", x = features[,2])
    
    # Create a vector with features' names (these names will be used as dataset columns' names):
    u_std_names <- as.vector(features[u_std_indexes,2])
    
    # Select columns in dataset based on mean and std filtered features:
    dataset_u_std <- dataset[,u_std_indexes+3]
    ## Obs.: the "+3" term is necessary because it was added 3 columns in the original "train" and "test" data (when data frames were joined and re-ordered in step 1)
    
    # Re-set dataset columns' names:
    setnames(x = dataset_u_std, old = names(dataset_u_std), new = u_std_names)
    
    # Insert dataset's 3 first columns in dataset_u_std:
    dataset <- cbind(dataset[,1:3], dataset_u_std)
    # dataset2 <- cbind(dataset[,1:3], dataset_u_std)

    # Viewing the resulting data set:
    # View(dataset)

    
## 3-) Uses descriptive activity names to name the activities in the data set

    # Read activities' names data:
    act <- read.table("./activity_labels.txt")
    
    # Change "act" columns' names:
    setnames(x = act, old = names(act), new = c("act", "act_name"))

    # Set "act" and "dataset" as data.table:
    act <- as.data.table(act)
    dataset <- as.data.table(dataset)

    # Set key in "act" and "dataset" as data.tables:
    setkey(x = act, "act")
    setkey(x = dataset, "act")


## 4-) Appropriately labels the data set with descriptive variable names
    
    # Merge "dataset" and "act" tables in order to insert a column in dataset table with the activity description:
    dataset <- merge(dataset, act, by = "act")

    # Viewing the resulting data set:
    # View(dataset)

## 5-) Creates an independent tidy data set with the average of each variable for each activity and each subject
    
    # Create a new dataset:
    dataset_tbl_dt <- tbl_dt(dataset)
    
    # Create the tidy data set:
    for (i in 4:69){
        summarise(dataset_tbl_dt, mean(dataset_tbl_dt[,i,with=F],na.rm=T))
    }
    
    # IT WAS NOT POSSIBLE FINISHED IT AT TIME TO BE SEND TO SUBMISSION!
    
    # Send file to submission:
    write.table(x = dataset_tbl_dt, file = "dataset.txt", row.names = F)
