
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
shinydashboard::dashboardPage(title = "Retailify App",
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
      
      #### Administration Screen #####
      shinydashboard::tabItem(tabName = "admin",uiOutput("adminUI")),
      
      #### Invoicing Screen #####
      shinydashboard::tabItem(tabName = "invoice",uiOutput("invoiceUI")),
      
      #### Purchase Screen #####
      shinydashboard::tabItem(tabName = "purchase",uiOutput("purchaseUI")),
      
      #### Staffing Screen #####
      shinydashboard::tabItem(tabName = "staffing",uiOutput("staffingUI")),
      
      #### Account Screen #####
      shinydashboard::tabItem(tabName = "account",uiOutput("accountUI")),
      
      #### Expense Screen #####
      shinydashboard::tabItem(tabName = "expense",uiOutput("expenseUI")),
      
      #### Taxation Screen #####
      shinydashboard::tabItem(tabName = "taxation",uiOutput("taxationUI")),
      
      #### Analytics Screen #####
      shinydashboard::tabItem(tabName = "analytics",uiOutput("analyticsUI")),
      
      #### Banking Screen #####
      shinydashboard::tabItem(tabName = "banking",uiOutput("bankingUI")),
      
      #### Manual Screen #####
      shinydashboard::tabItem(tabName = "manual",
                              tags$h3(tags$b("We will provide the Manual soon..."),style = "text-align: center;")
                              ),
      
      #### Help Screen #####
      shinydashboard::tabItem(tabName = "help",br(),br(),br(),br(),
                              tags$h3(tags$b("For Help, Please contact..."),style = "text-align: center;"),
                              tags$h4(tags$b("Ashutosh Agrahari"),style = "text-align: center;"),
                              tags$h4(icon("fal fa-envelope"), tags$a("akagr.cse@gmail.com"),style = "text-align: center;"),
                              tags$h3(tags$ul(
                                  a(href = 'https://github.com/AshutoshAgrahari/',icon("fal fa-github")),
                                  a(href = 'https://www.linkedin.com/in/ashutosh-agrahari-55242116/',icon("fal fa-linkedin")),
                                  class = "dropdown", style = "text-align: center;"))
                              )
    ),
    
    #### Footer ####
    tags$footer(HTML("<strong>Copyright &copy;", lubridate::year(Sys.Date()), 
                     "All rights reserved. <b>ReBiAcApp V1.0 Beta | Developed By: Ashutosh Agrahari </b>"), 
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



