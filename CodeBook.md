### "GETTING AND CLEANING DATA" Program Assignement

PREVIOUS STEPS:

    P.1 Set working directory for running this project;
    P.2 Download data;
    P.3 Unzip zipfile;
    P.4 Delete .zip file;
    P.5 Rename data folder;
    P.6 Set working directory;
    P.7 Load packages to be used.
    
1. Merge the training and the test sets to create one data set:

    1.1 Read data;
    1.2 Re-set column names on 1-variable data sets ("label" and "subject");
    1.3 Create a "data_type" column in "train" and "test" datasets;
    1.4 Join "train" and "test" data in the same data frame;
    1.5 Join data frames;
    1.6 Re-order columns in "train" and "test" tables, in order to put "data_type" as the first column;
    1.7 Remove intermediate tables that will no more be used;
    
    
2. Extracts only the measurements on the mean and standard deviation for each measurement:

    2.1 Read features data;
    2.2 Filter measurements containing "mean" or "std" on "features" data frame's 2nd column;
    2.3 Create a vector with features' names (these names will be used as dataset columns' names);
    2.4 Select columns in dataset based on mean and std filtered features;
    2.5 Insert dataset's 3 first columns in dataset_u_std.


3. Uses descriptive activity names to name the activities in the data set:

    3.1 Read activities' names data;
    3.2 Change "act" columns' names;
    3.3 Set "act" and "dataset" as data.table;
    3.4 Set key in "act" and "dataset" as data.tables.
    

4. Appropriately labels the data set with descriptive variable names:

    4.1 Merge "dataset" and "act" tables in order to insert a column in dataset table with the activity description.


5. Creates an independent tidy data set with the average of each variable for each activity and each subject:
            
    5.1 Apply 'summarize' function for each variable in the dataset and put into the list created previously;
    5.2 Re-set dataset columns' names;
    5.3 Send file to submission.
