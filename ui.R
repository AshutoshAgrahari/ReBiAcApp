
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
    tags$li(class = "dropdown",tags$h4(textOutput("loggedDetail")),style = "padding-top:10px; padding-bottom:1px;"),
    tags$li(class = "dropdown", 
            actionButton("home", "Home", class="button button1"),
            actionButton("login", "Login", class="button button1"),
            bsTooltip("home", "Click to Home Screen","left", options = list(container = "header")),
            bsTooltip("login", "Click to Login box","right", options = list(container = "header"))
    ),
    tags$li(a(href = 'https://github.com/AshutoshAgrahari/ReBiAcApp',
              img(src = 'img/Agrahari Consulting Logo2.png',title = "Company Home", height = "30px"),
              style = "padding-top:10px; padding-bottom:5px;"
              ),
            class = "dropdown")
    ),
  shinydashboard::dashboardSidebar(
    sidebarMenu(id = "sidebarTabs",
                menuItem(text = "Home", tabName = "home", icon = icon("fas fa-home")),
                menuItem(text = "Administration", tabName = "admin", icon = icon("fas fa-cogs")),
                menuItem(text = "Invoicing", tabName = "invoice", icon = icon("fas fa-cart-plus")),
                menuItem(text = "Stocking", tabName = "purchase", icon = icon("fas fa-coins")),
                menuItem(text = "Staff Management", tabName = "staffing", icon = icon("fas fa-users")),
                menuItem(text = "Accounting", tabName = "account", icon = icon("fas fa-briefcase")),
                menuItem(text = "Expenses", tabName = "expenses", icon = icon("fas fa-rupee-sign")),
                menuItem(text = "Taxation", tabName = "taxation", icon = icon("fas fa-clipboard-list")),
                menuItem(text = "Analytics", tabName = "analytics", icon = icon("fas fa-chart-line")),
                menuItem(text = "Banking", tabName = "banking", icon = icon("fas fa-piggy-bank")),
                menuItem(text = "Manual", tabName = "manual", icon = icon("fas fa-book-open")),
                menuItem(text = "Help", tabName = "help", icon = icon("fal fa-question-circle"))
                )
    ),
  shinydashboard::dashboardBody(
    theme_ReBiAcApp,
    useShinyalert(),
    useShinyjs(),
    tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")),
    extendShinyjs(text = jscode),
    shinydashboard::tabItems(
      #### Home page #####
      shinydashboard::tabItem(tabName = "home",
                tags$b(tags$h1("Retailfy Application: Retail Billing Accounting Application", style = "text-align: center;")),
                p(img(src="img/Agrahari Consulting(2).png", align ="middle", width = "500",hight = "500"), style = "text-align: center"),
                tags$p("Developed By: Ashutosh Agrahari", style = "text-align: right;")
      ),
      
      #### Administration page #####
      shinydashboard::tabItem(tabName = "admin",uiOutput("adminUI")),
      shinydashboard::tabItem(tabName = "invoice",uiOutput("invoiceUI")),
      shinydashboard::tabItem(tabName = "purchase",uiOutput("purchaseUI")),
      shinydashboard::tabItem(tabName = "staffing",uiOutput("staffingUI")),
      shinydashboard::tabItem(tabName = "account",uiOutput("accountUI")),
      shinydashboard::tabItem(tabName = "expense",uiOutput("expenseUI")),
      shinydashboard::tabItem(tabName = "taxation",uiOutput("taxationUI")),
      shinydashboard::tabItem(tabName = "analytics",uiOutput("analyticsUI")),
      shinydashboard::tabItem(tabName = "banking",uiOutput("bankingUI")),
      shinydashboard::tabItem(tabName = "manual",uiOutput("manualUI")),
      shinydashboard::tabItem(tabName = "help",tags$h4(tags$b("For Help, Please contact at akagr.cse@gmail.com")))
    ),
    #### Footer ####
    tags$footer(HTML("<strong>Copyright &copy; 2019 All rights reserved. <b>ReBiAcApp V1.0 Beta | Developed By: Ashutosh Agrahari </b>"), 
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