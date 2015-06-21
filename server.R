library(shiny)
library("rpart")
library("caret")

loadTheData <- function()
{
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
  
  return(theData)
}

loadModel<-function()
{
    load("theModel")
    return(fit);
}

shinyServer(function(input, output) {
  fit<-loadModel();
  loadedData<-loadTheData();

  output$distPlot <- renderPlot({
    partData<-theData[theData$ActivityCategory==input$activityCategory,]
    hist(as.numeric(partData$Activity),breaks=nlevels(partData$Activity),main=sprintf("Number of children registered by to category %s",input$activityCategory),xlab="Activity")
  })
  
  output$result <- renderText({
    df<-data.frame("RegisteredParents"=as.numeric(input$regParents),"KidsCount"=as.numeric(input$kidsCount),
                   "Activity"=factor(input$activity),"ActivityCategory"=factor(input$activityCategory),
                   "IsKinderGarden"=factor(as.numeric(input$isKinder)),"Class"=factor(input$class),
                   "SensitivityOrLimitation"=factor(1),"RegistrationFee"=as.numeric(input$regFee),
                   "KidNumberToRegister"=as.numeric(input$kidNumber), "Price"=as.numeric(input$Price),
                   "Monthly"=as.numeric(input$monthly),"OneTime"=as.numeric(input$oneTime))
    res<-predict(fit,df)
    if (res==1)
      "Will register"
    else
      "Won't register"
  })
  
  
  
})