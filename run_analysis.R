library(plyr)

xTrain <- read.table("train/xTrain.txt")
yTrain <- read.table("train/yTrain.txt")
subjectTrain <- read.table("train/subjectTrain.txt")

xTest <- read.table("test/xTest.txt")
yTest <- read.table("test/yTest.txt")
subjectTest <- read.table("test/subjectTest.txt")

xData <- rbind(xTrain, xTest)

yData <- rbind(yTrain, yTest)

subjectMerged <- rbind(subjectTrain, subjectTest)

features <- read.table("features.txt")

mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

xData <- xData[, mean_and_std_features]

names(xData) <- features[mean_and_std_features, 2]

activities <- read.table("activity_labels.txt")

yData[, 1] <- activities[yData[, 1], 2]

names(yData) <- "activity"

names(subjectMerged) <- "subject"

allData <- cbind(xData, yData, subjectMerged)

averagesData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averagesData, "step_5.txt", row.name=FALSE)