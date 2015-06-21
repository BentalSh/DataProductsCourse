load("loadData.R")
dataToWorkWith<-theDataToLearn[complete.cases(theDataToLearn),]
dataToWorkWith<-dataToWorkWith[rowSums(is.na(dataToWorkWith))==0,]
inTrain<-createDataPartition(dataToWorkWith$Status,p=0.75,list=FALSE)
training<-dataToWorkWith[inTrain,]
testing<-dataToWorkWith[-inTrain,]

fit<-train(Status~.,training,method="gbm")