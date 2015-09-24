# Getting_Cleaning_Data_CourseProject

This repository contains 2 main files:

## CodeBook.md

This file describes the internal workings of run_analysis.R. It describes
the logic of each step, and the final results that are created in R's
workspace.

## run_analysis.R

This file should be run as:

source("run_analysis.R")

This script takes care of all steps in the assignment. It downloads and
unzips the wearable data archive. It reads and merges the test and train
datasets. It labels the columns of the dataset. It converts the Activity
integers into a factor variable. Finally, it creates a dataset containing
the means of all columns with either "-mean()" or "-std()" in the
column name.

