##Course Project of Getting and Cleaning Data

####This is a R script, run_analysis.R, which is the course project for the Getting and Cleaning Data Coursera. The final dataset is stored in the file TidyData.txt. The script does the following steps:
 
##### 1. Download the dataset if it does not already exist in the working directory.
##### 2. Load the activity and feature info.
##### 3. Load both the training and test datasets, keeping only those columns which reflect a mean or standard deviation.
##### 4. Load the activity and subject data for each dataset, and merges those columns with the dataset.
##### 5. Merge the two datasets.
##### 6. Convert the activity and subject columns into factors.
##### 7. Create a tidy dataset that consists of the mean value of each variable for each subject and activity pair.