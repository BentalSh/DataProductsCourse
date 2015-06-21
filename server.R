library(shiny)
library("rpart")
library("caret")

loadTheData <- function()
{
  print("loading")
  theData<-read.csv("FinalQuery.csv",encoding="UTF-16LE")
  print("done loading")
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
  print("done with loading function")
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
    partData<-theData[theData$ActivityCategory==input$activityCategory & theData$Status==1,]
    hist(as.numeric(partData$Activity),breaks=nlevels(factor(partData$Activity)),main=sprintf("Number of children registered by to category %s",input$activityCategory),xlab="Activity")
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