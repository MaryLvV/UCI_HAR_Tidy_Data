run_analysis <- function()    {
      readData()
      combineData()
      addColumnNames()
      getSubset()
      getActivityLabels()
      calculateAverages()
      writeFile()

      
      readData <- function()  {
            ## first read in the training data, training activity ids, training subject ids
            ## and bind them to a single dataframe called "traingroup"
            train <- read.table("train/x_train.txt", header=FALSE)
            trainactivity <- read.table("train/y_train.txt", header=FALSE)
            trainsubject <- read.table("train/subject_train.txt", header=FALSE)
            traingroup <- cbind(trainsubject,trainactivity,train)
            
            ## next read in the testing data, testing activity ids, testing subject ids
            ## and bind them to a single dataframe called "testgroup"
            test <- read.table("test/x_test.txt", header=FALSE)
            testactivity <- read.table("test/y_test.txt", header=FALSE)
            testsubject <- read.table("test/subject_test.txt", header=FALSE)
            testgroup <- cbind(testsubject,testactivity,test)
      }
      combineData <- function()     {
            ## using the rbind() function, combine traingroup and testgroup into one dataframe called "allgroup"
            allgroup <- rbind(testgroup,traingroup)
      }

      addColumnNames <- function()  {
            ## now that the data is combined, we need to give it meaningful column names
            ## column names for the main data sets are available in the features.txt file
            ## but we'll need to add the subject and activity column names separately
            ## create an empty vector to store the column names and add the first two columns: "subject" and "activity"
            ## read the features from feature.txt into a vector and append that to the colnames vector, 
            ## completing the list of column names
            colnames <- vector()
            colnames <- append(colnames, "subject", after=length(colnames))
            colnames <- append(colnames, "activity", after=length(colnames))
            features <- read.table("features.txt", header=FALSE)
            featurevector <- as.character(features$V2)
            colnames <- append(colnames, featurevector, after=length(colnames))
            
            ## use the vector of column names we have built to set the column names of the allgroup data frame
            colnames(allgroup) <- colnames
       }
      getSubset <- function ()       {
            ## find the names of the columns that show measurements for mean and standard deviation
            ## and store them in a vector called "mycols" don't forget to store the subject and activity columns
            ## since we'll need those too
            meancols <- grep("mean\\(\\)",colnames(allgroup), value=TRUE)
            stdcols <- grep("std()",colnames(allgroup), value=TRUE)
            mycols <- vector()
            mycols <- append(mycols, "subject", after=length(mycols))
            mycols <- append(mycols, "activity", after=length(mycols))
            mycols <- append(mycols, meancols, after=length(mycols))
            mycols <- append(mycols, stdcols, after=length(mycols))
            
            ## create a new dataframe called "mydata" with just the measurements for mean and standard deviation
            mydata <- allgroup[which(colnames(allgroup) %in% mycols)]
      }
      getActivityLabels <- function()     {
            ## now update the activity column with meaningful activity names unstead of numbers
            for (i in 1:nrow(mydata))    {
                  if (mydata[i,2] == 1)  {
                        mydata[i,2] <- "walking"
                  }
                  else if (mydata[i,2] == 2)  {
                        mydata[i,2] <- "walking upstairs"
                  }
                  else if (mydata[i,2] == 3)  {
                        mydata[i,2] <- "walking downstairs"
                  }
                  else if (mydata[i,2] == 4)  {
                        mydata[i,2] <- "sitting"
                  }
                  else if (mydata[i,2] == 5)  {
                        mydata[i,2] <- "standing"
                  }
                  else if (mydata[i,2] == 6)  {
                        mydata[i,2] <- "laying"
                  }
                  else   {
                        mydata[i,2] <- "NA"
                  }
            }
      }
      calculateAverages <- function ()       {
            ## now split the data frame on subject and then calculate the mean for each subject on each activity
            subjectsplit <- split(mydata,mydata$subject)
            subjectmeans <- lapply(subjectsplit, function(x) colMeans(x[ ,3:68]))
      }
      writeFile <- function ()       {
            ## write the subjectmeans to a file
                  write.table(subjectmeans, file = "HAR_SubjectMeans.txt", row.names=FALSE)
                  print("tidy data has been printed to your working directory")
            ## create a descriptions file of the mean and std measures for which the means have been calculated
            ## in the subjectmeans file
            ## uncomment the two lines below to create a file with the measurement descriptions
                  ##featuremeasures <- colnames(mydata)
                  ##featuremeasures <- featuremeasures[!featuremeasures %in% c("subject","activity")]
      }

}