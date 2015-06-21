library("rpart")
library("caret")

theData<-read.csv("FinalQuery.csv",stringsAsFactors=FALSE)
theData$RegistrationFee <- as.numeric(trimws(sub("\\₪","", theData$RegistrationFee)))
theData$Price <- as.numeric(trimws(sub("\\₪","", sub(",","",theData$Price))))
theData$Monthly <- as.numeric(trimws(sub("\\₪","", sub(",","",theData$Monthly))))
theData$OneTime <- as.numeric(trimws(sub("\\₪","", sub(",","",theData$OneTime))))

theData$Status=factor(theData$Status)
theData$Activity=factor(theData$Activity)
theData$ActivityCategory=factor(theData$ActivityCategory)
theData$Year=factor(theData$Year)
theData$IsKinderGarden=factor(theData$IsKinderGarden)
theData$Class=factor(theData$Class)
theData$School=factor(theData$School)
theData$SensitivityOrLimitation=factor(theData$SensitivityOrLimitation)
theData<-theData[,-c(4,10)]

theDataToLearn<-theData[,-c(1:2)]
theDataToLearn<-theDataToLearn[,-c(6)]