Ken Gosier
Code Book, Getting and Cleaning Data, Course Project, Coursera
Sep 2015

# Code Book, Wearable Data Project

This code book describes the steps of run_analysis.R.

The script begins by downloading and unzipping the zip file from the
remote URL. It names the local file and folder to store the data in.
Any pre-existing copies are deleted.

It next reads out the activity label file, in order to create a
mapping from activity numbers (1,2,..) to labels (WALKING,
WALKING_UPSTAIRS,...). Labels will be used as a factor variable.

features are next read in for labelling the dataset columns. These
are stored as a character vector.

The variable colname.list is created, which includes "Subject" and
"Activity" for naming the columns in the dataset data frame.

(Please note that the steps of the run_analysis.R are in a slightly
different order than the steps listed with the assignment. The steps
of the script were made to make the overall process simpler and
cleaner.)

Next a loop is made over the test and train datasets. For each:
* The subject list is read in as an integer vector
* The activity list is read in as an integer vector, and converted
to a factor vector
* The data file is read in through read.table.
* The subject and activity columns are bound onto the dataset,
and column names are added.
* The resulting type.dataset (type is for test and train) is added
into the overall dataset variable.

Next, all dataset columns not matching on "-mean()" or "-std()" are
removed. Also, the Subject and Activity columns are removed, so that
the mean.std.dataset data frame can be used more easily with R's
aggregate function.

The aggregate function is called in the last step, to take the mean
by Subject and Activity. Several values have been checked against the
raw data, to make sure outputs agree.

At the end, the local folder is removed, to clean up a bit.

The end products are:
* meanstd.dataset, which contains all "-mean()" and "-std()"
columns from from both the test and train set.
* summary.dataset, which aggregates the means of the columns
of meanstd.dataset by Subject and Activity.

All objectives for the course project have been met:
* Test and train sets merged
* The measurements on mean() and std() have been extracted
* The activities have been created as a factor variable, with
descriptive names rather than integer codes.
* All columns have descriptive names
* The data frame summary.dataset has been created with means
by Subject and Activity.


