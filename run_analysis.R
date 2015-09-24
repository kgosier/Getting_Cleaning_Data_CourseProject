run_analysis <- function(download = FALSE, 
    outfile = "./summary_dataset.txt") {

    fileurl <- sprintf("%s/%s",
        "https://d396qusza40orc.cloudfront.net",
        "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
    localfile <- "getdata-projectfiles-UCI HAR Dataset.zip"
    local.archive <- "./UCI HAR Dataset"

    if (download) {

        #download zip file. delete any local file previously downloaded

        if (file.exists(localfile)) {
            file.remove(localfile)
        }
        download.file(fileurl, localfile)

        #unzip to a local archive. delete any existing local archive
        #previously unzipped here

        if (file.exists(local.archive)) {
            unlink(local.archive, recursive = TRUE)
        }
        unzip(localfile)
    }

    #read activity labels. data frame will contain int's in the first
    #column, and the labels as a factor variable in the 2nd column

    activity.label.file <- sprintf("%s/activity_labels.txt", local.archive)
    act.label <- read.table(activity.label.file)

    #features (column labels) for the dataset. store as character vector

    features.file <- sprintf("%s/features.txt", local.archive)
    features <- read.table(features.file)
    features <- as.character(features$V2)

    #column names for the dataset. append Subject and Activity onto the
    #front of the feature list

    colname.list <- c("Subject", "Activity", features)

    #create datasets for test and train, and append them into a single
    #data frame

    all.dataset <- NULL
    for (type in c("test","train")) {

        #subject list. save as int vector rather than data frame

        subj.list.file <- sprintf("%s/%s/subject_%s.txt", local.archive,
            type, type)
        subj.list <- read.table(subj.list.file)
        subj.list <- subj.list$V1

        #activity list for the dataset. save as vector of factors

        act.list.file <- sprintf("%s/%s/y_%s.txt", local.archive,
            type, type)
        act.list.int <- read.table(act.list.file)
        act.list.factor <- act.label$V2[act.list.int$V1]

        #the actual dataset

        type.dataset.file <- sprintf("%s/%s/X_%s.txt", local.archive,
            type, type)
        type.dataset <- read.table(type.dataset.file)

        type.dataset <- cbind(subj.list, act.list.factor, type.dataset)
        colnames(type.dataset) <- colname.list

        #make a single dataset out of the 2. if on the 2nd iteration,
        #rbind type.dataset onto dataset

        if (is.null(all.dataset)) {
            all.dataset <- type.dataset
        } else {
            all.dataset <- rbind(all.dataset, type.dataset)
        }
    }#type

    #columns containing "mean" or "std" variables. only match on "-mean()" and
    #"-std()". There are some columns names "meanFreq", for example, which we don't
    #want. Many extra \'s are needed to do this match.

    meanstdsub <- grep("\\-mean\\(\\)|\\-std\\(\\)", colname.list)
    meanstd.dataset <- all.dataset[,meanstdsub]

    #create means by Subject and Activity

    summary.dataset <- aggregate(meanstd.dataset, 
        by = list(Subject = all.dataset$Subject, Activity = all.dataset$Activity),
        FUN = mean, na.rm=TRUE)

    #write the output file

    write.table(summary.dataset, outfile, row.names = FALSE)

    #clean up a little bit. Let the zip stay in case we need it, but remove
    #the unzipped folder
    
    if (download) {
        if (file.exists(local.archive)) {
            unlink(local.archive, recursive = TRUE)
        }
    }

    summary.dataset
}#function