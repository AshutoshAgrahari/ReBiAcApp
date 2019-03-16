
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
    title = logo_ReBiAcApp,
    tags$li(class = "dropdown", actionButton("home", "Home", class="button button1"),
            actionButton("login", "Login", class="button button1")),
    tags$li(class = "dropdown",uiOutput("logout")),
    tags$li(a(href = 'https://github.com/AshutoshAgrahari/ReBiAcApp',
              img(src = 'img/Agrahari Consulting Logo2.png',title = "Company Home", height = "30px"),
              style = "padding-top:10px; padding-bottom:5px;"
              ),
            class = "dropdown")
    ),
  shinydashboard::dashboardSidebar(
    sidebarMenu(id = "tabs",
                menuItem("Home", tabName = "home", icon = icon("fas fa-home")),
                menuItem("Administration", tabName = "admin", icon = icon("fas fa-home")),
                menuItem("Invoicing", tabName = "invoice", icon = icon("fas fa-home")),
                menuItem("Stocking", tabName = "purchase", icon = icon("fas fa-home")),
                menuItem("Staff Management", tabName = "staffing", icon = icon("fas fa-home")),
                menuItem("Accounting", tabName = "account", icon = icon("fas fa-home")),
                menuItem("Expenses", tabName = "expenses", icon = icon("upload")),
                menuItem("Taxation", tabName = "taxation", icon = icon("upload")),
                menuItem("Manual", tabName = "manual", icon = icon("upload")),
                menuItem("Help", tabName = "help", icon = icon("upload"))
                )
    ),
  shinydashboard::dashboardBody(
    theme_ReBiAcApp,
    useShinyalert(),
    useShinyjs(),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
    ),
    #extendShinyjs(text = jscode),
    tabItems(
      tabItem(tabName = "home",
              HTML('<p><strong><h1 style = "text-align: center"> Retail Billing Accounting Application [Retailfy]</h1></p>'),
              p(img(src="img/Agrahari Consulting(2).png", align ="middle", width = "500",hight = "500"), style = "text-align: center"),
              HTML('<p align= "right">Developed By: Ashutosh Agrahari </p>')
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