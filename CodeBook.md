Ken Gosier,
Code Book, Getting and Cleaning Data, Course Project, Coursera,
Sep 2015

# Code Book, Wearable Data Project

This code book describes the steps of the run_analysis()
function in run_analysis.R.

The function has 2 optional arguments. The download parameter
defaults to FALSE. The outfile argument defaults to
"./summary_dataset.txt".

If download is set to TRUE, then the script begins by downloading 
the file from the remote URL. It
names the local file and folder to store the data in. Any
pre-existing copies are deleted.

It next reads out the activity label file, in order to create
a mapping from activity numbers (1,2,..) to labels (WALKING,
WALKING_UPSTAIRS,...). Labels will be used as a factor variable.

Features are next read in for labelling the dataset columns.
These are stored as a character vector.

The variable colname.list is created, which includes "Subject"
and "Activity" for naming the columns in the dataset data frame.

(Please note that the steps of the run_analysis.R are in a 
slightly different order than the steps listed with the assignment. The steps of the script were made to make the 
overall process simpler and cleaner.)

Next a loop is made over the test and train datasets. For each:
* The subject list is read in as an integer vector
* The activity list is read in as an integer vector, and converted to a factor vector
* The data file is read in through read.table.
* The subject and activity columns are bound onto the dataset,
and column names are added.
* The resulting type.dataset (type is for test and train) is added into the overall dataset variable.

Next, the data frame meanstd.dataset is created by taking all 
columns from all.dataset not matching on "-mean()" or "-std()".
The Subject and Activity columns are not included in
meanstd.dataset, so that the data frame can be used more easily 
with R's aggregate function.

The aggregate function is called in the last step, to take the mean by Subject and Activity. Several values have been checked against the raw data, to make sure outputs agree.

At the end, the local folder is removed, to clean up a bit.

The end products are:
* summary.dataset is returned. This is a data frame which 
aggregates the means of the columns of meanstd.dataset by
Subject and Activity. The Subject and Activity columns are
included in summary.dataset.
* summary.dataset is also written to the file named in the
parameter outfile, which defaults to "./summary_dataset.txt".

All objectives for the course project have been met:
* Test and train sets merged
* The measurements on "-mean()" and "-std()" have been extracted
* The activities have been created as a factor variable, with
descriptive names rather than integer codes.
* All columns have descriptive names
* The data frame summary.dataset has been created with means
by Subject and Activity.


