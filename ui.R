library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Children's courses and activity predictions"),
  h6("This page tries to give information for the directors of a company that provides services for after school activities"),
  h6("The activities provided are numbered (from 1-50), and are categorized according to 3 categories (1-3)"),
  h6("To keep data about the company secret, we numerized all the data, and no names will be display(For example, no activity names will be displayed)"),
  h6("Category 1 is not very interesting as it only contains 1 activity"),
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    
    sidebarPanel(
      radioButtons("activityCategory","Activity category (1-3)",c("1" = "1",
                                                                  "2" = "2",
                                                                  "3" = "3"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Number of children by category"),
      h6("Here we display the number of children registered to each activity, by category"),
      plotOutput("distPlot")
    )
  ),
  sidebarLayout(
    
    sidebarPanel(
      textInput("regParents","Number of registered parents (1-2)",
                value = 1),
      textInput("kidsCount","Number of kids for the parents (1-10)",
                value = 1),
      textInput("activity","The activity (1-50)",
                value = 1),
      checkboxInput("isKinder","Is kindergarden?",
                value=FALSE),
      textInput("class","The Class (1-18)",
                value = 1),
      textInput("kidNumber","The kid number to register(0 for the first one, 1 for the second brother etc...",value=0),
      textInput("regFee","The registration fee",
                value = 0),
      textInput("oneTime","One time payments already paid this year",
                value = 0),
      textInput("monthly","Monthly payments already paid this year",
                value = 0),
      textInput("Price","Price for the activity",
                value = 1500)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Predict registration to category 2"),
      h6("Note that we appear to overfit the data where price is large"),
      h6("That is probably caused by the facts that the negatives (i.e. kids who didn't register to activities) are simulated data, as kids who didn't register mostly didn't even started the registration process"),
      h1(textOutput("result"))

    )
  )
))