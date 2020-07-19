#reading features and activity data
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

##################################### Question 1 ########################################
# reading train data
train <- read.table("./UCI HAR Dataset/train/X_train.txt") #features data
colnames(train) = features$V2
trainl = read.table("./UCI HAR Dataset/train/Y_train.txt") #label data
train$activities = trainl$V1
trains = read.table("./UCI HAR Dataset/train/subject_train.txt") #label data
train$subject = trains$V1

# reading test data
test <- read.table("./UCI HAR Dataset/test/X_test.txt") #features data
colnames(test) = features$V2
testl = read.table("./UCI HAR Dataset/test/Y_test.txt") #label data
test$activities = testl$V1
tests = read.table("./UCI HAR Dataset/test/subject_test.txt") #label data
test$subject = tests$V1

# merge data
dat = rbind(train, test)

##################################### Question 2 ########################################
dat_filter = dat[,grep('mean|std|activities|subject',colnames(dat))]

##################################### Question 3 ########################################
dat_filter$activitylabel <- factor(dat_filter$activities, labels= c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
dat_filter$activitylabel

##################################### Question 4 ########################################

tidy_dat = aggregate(.~activities + subject, dat_filter, FUN = mean)
write.table(tidy_dat, "tidy_data.txt", row.names = FALSE )
