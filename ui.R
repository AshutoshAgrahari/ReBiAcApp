
# Required libraries for shiny UI
library(shiny)            # used to shiny APP
library(shinydashboard)   # Used for shiny dashboard
library(dashboardthemes)  # Used for custom theme building
library(shinyjs)          # Used to include java script code
library(shinyBS)          # Used to include Models in Shiny
library(shinyalert)       # Used for shiny alert message.
library(V8)               # Used to run custom java script code.

# Source the theme R file in UI.
source("shinyThemeUtils.R")

# Shiny Dashboard code.
shinydashboard::dashboardPage(title = "ReBiAcApp",
  shinydashboard::dashboardHeader(
    title = logo_ReBiAcApp
    ),
  shinydashboard::dashboardSidebar(
    sidebarMenu(id = "tabs",menuItem("User Management", tabName = "ML_WB", icon = icon("upload")))
    ),
  shinydashboard::dashboardBody(
    theme_ReBiAcApp,
    useShinyalert(),
    useShinyjs(),
    #extendShinyjs(text = jscode),
    
    
    tabItems(
      tabItem(tabName = "ML_WB",
              HTML('<p><strong><h1> Retail Billing Accounting Application [Retailfy]</h1></p>
                   <p>Developed By: Ashutosh Agrahari </p>'
                   )
              )
    ),
    #### Footer ####
    tags$footer(HTML("<strong>Copyright &copy; 2019 All rights reserved. <b>ReBiAcApp V1.0 Beta</b>"), 
                align = "center", 
                style = "position:absolute;
                bottom:0;
                width:90%;
                height:30px; 
                color: rgb(0, 147, 150);
                #padding: 10px;
                background-color: white;
                z-index: 1000;")
    )
  #### End ####
  
)