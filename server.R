function(input, output, session){
  
  #### Global Variables ####
  RecValues <- reactiveValues(
    authenticated = FALSE, # When Login button is clicked, attempt to authenticate user. If successful remove the login modal. 
    userLoginTable = NULL  # User Login and access table for display for admin.
    )
  
  #### Login Feature ####
  # Login Model Dialogue Box
  observeEvent(input$login,{
    if(RecValues$authenticated == FALSE){  # If Condition for login
      showModal(fnLoginModal())
    }else{  # If Condition for logout
      RecValues$authenticated <- FALSE
      updateActionButton(session = session,inputId = "login",label = "Login")
      session$reload()
      js$refresh()
    }
  })
  
  # fnLoginModal returns UI as Modaldialog popup for user login
  fnLoginModal <- function(failed = FALSE) {
    modalDialog(title = tags$b("User Login"),size = "m",easyClose = T,fade = T,
                wellPanel(
                  textInput("usernameInput", tags$b("Username:"),placeholder = "Provide username",width = "100%"),
                  passwordInput("passwordInput", tags$b("Password:"),placeholder = "Provide password",width = "100%")
                ),
                actionButton("bntLogin", "Login",class = "button button1"),
                bsTooltip("bntLogin", "Click for Login","right", options = list(container = "body")),
                footer = NULL#, class = "modal-header modal-title modal-content modal-body"
    )
  }
  
  # validate user login detail
  observeEvent(input$bntLogin,{
    isolate({
      Username <- input$usernameInput
      Password <- input$passwordInput
    })
    
    if(file.exists(userLoginTablePath)){
      RecValues$userLoginTable <- readxl::read_xlsx(path = userLoginTablePath)
      RecValues$userLoginTable$UserID <- as.integer(RecValues$userLoginTable$UserID)
      Id.username <- which(RecValues$userLoginTable$Username == Username)
      Id.password <- which(RecValues$userLoginTable$Password == Password)
      if (length(Id.username) > 0 & length(Id.password) > 0){
        if (Id.username == Id.password) {
          RecValues$authenticated <- TRUE
          removeModal()
          customAlert("Welcome to Retailify App.", alertType = "success")
          updateActionButton(session = session,inputId = "login",label = "Logout")
          
          output$loggedDetail <- renderText({
            invalidateLater(1000, session)
            paste0("Logged User: ",Username," | ",Sys.time(),"|")
          })
          
        } else {
          RecValues$authenticated <- FALSE
          customAlert(message = "Wrong username or password, please try again!",alertType = "error")
        }     
      }else {
        RecValues$authenticated <- FALSE
        customAlert(message = "Wrong username or password, please try again!",alertType = "error")
      }
    }else{
      customAlert(message = "unable to connect with Login server. Please connect with helpdesk.", alertType = "error")
    }
  })
  
  # updating tab panel to home screen, when user click on home.
  observeEvent(input$home,{
    updateTabItems(session, inputId = "sidebarTabs",selected = "home")
  })
  
  #### Admin Module #####
  # Display Admin Screen UI
  output$adminUI <- renderUI({
    tagList(
      AGBox(title="New User Registration:", width=12,
            splitLayout(
              textInput("newUserEmailID","Email ID:",value = "demo@test.com"),
              textInput("newUserName","UserName:",value = "test"),
              textInput("newUserPassword","Password:",value = "test@123")
            ),
            actionButton("createNewUserLogin", "Create New User", class="button button1"),
            bsTooltip("createNewUserLogin", "Click to create new user account, access can be update in user access table.","right", options = list(container = "body"))
      ),
      AGBox(title="User Login Access Grid", width=12,
            rhandsontable::rHandsontableOutput('userLoginTable',width = "100%"),br(),
            actionButton("updateUserAccessTable", "Update", class="button button1"),
            bsTooltip("updateUserAccessTable", "Click to update the User detail and Access.","right", options = list(container = "body"))
      )
    )
  })
  
  # Display User Login and Access table.
  output$userLoginTable <- rhandsontable::renderRHandsontable({
    rhandsontable::rhandsontable(RecValues$userLoginTable, #MasterList[["userLoginTable"]],
                                 useTypes = TRUE, stretchH = "all",rowHeaders = NULL,fillHandle = FALSE) %>%
      hot_table(highlightCol = TRUE, highlightRow = TRUE) %>%
      hot_col(c("UserID"), readOnly = TRUE)%>%
      hot_cols(fixedColumnsLeft = 4) %>%
      hot_context_menu(allowRowEdit = FALSE, allowColEdit = FALSE)
  })
  
  # Updating the table
  observeEvent(input$updateUserAccessTable,{
    userLoginTable <- hot_to_r(input$userLoginTable)
    RecValues$userLoginTable <- userLoginTable[userLoginTable$RemoveFlag == FALSE,]
    openxlsx::write.xlsx(RecValues$userLoginTable,userLoginTablePath)
  })
  
  # Creating new user
  observeEvent(input$createNewUserLogin,{
    userLoginTable <- RecValues$userLoginTable
    tmpUserDetail <- data.frame(max(userLoginTable$UserID)+1,input$newUserName,input$newUserPassword,input$newUserEmailID, matrix(rep(TRUE, length(userLoginTable)-5),nrow = 1), FALSE)
    names(tmpUserDetail) <- names(userLoginTable)
    RecValues$userLoginTable <- rbind(userLoginTable,tmpUserDetail)
    openxlsx::write.xlsx(RecValues$userLoginTable,userLoginTablePath)
  })
  
}