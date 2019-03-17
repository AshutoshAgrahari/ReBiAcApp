function(input, output, session){
  
  observeEvent(input$login,{
    if(varValues$authenticated == FALSE){  # If Condition for login
      showModal(fnLoginModal())
    }else{  # If Condition for logout
      varValues$authenticated <- FALSE
      updateActionButton(session = session,inputId = "login",label = "Login")
      session$reload()
      js$refresh()
    }
  })
  
  # kfnLoginModal returns UI as Modaldialog popup for user login
  fnLoginModal <- function(failed = FALSE) {
    modalDialog(title = tags$b("User Login"),size = "m",easyClose = T,fade = T,
                wellPanel(
                  textInput("usernameInput", tags$b("Username:"),placeholder = "Provide username",width = "100%"),
                  passwordInput("passwordInput", tags$b("Password:"),placeholder = "Provide password",width = "100%")
                ),
                actionButton("bntLogin", "Login",class = "button button1"),
                footer = NULL#, class = "modal-header modal-title modal-content modal-body"
    )
  }
  
  # When Login button is clicked, attempt to authenticate user. If successful remove the login modal. 
  varValues <- reactiveValues(authenticated = FALSE)
  
  # validate user login detail
  observeEvent(input$bntLogin,{
    isolate({
      Username <- input$usernameInput
      Password <- input$passwordInput
    })
    
    if(file.exists(userLoginTablePath)){
      userLoginTable <- readxl::read_xlsx(path = userLoginTablePath)
      Id.username <- which(userLoginTable$Username == Username)
      Id.password <- which(userLoginTable$Password == Password)
      if (length(Id.username) > 0 & length(Id.password) > 0){
        if (Id.username == Id.password) {
          varValues$authenticated <- TRUE
          removeModal()
          customAlert("Welcome to Retailify App.", alertType = "success")
          updateActionButton(session = session,inputId = "login",label = "Logout")
          
          output$loggedDetail <- renderText({
            invalidateLater(1000, session)
            paste0("Logged User: ",Username," | ",Sys.time(),"|")
          })
          
        } else {
          varValues$authenticated <- FALSE
          customAlert(message = "Wrong username or password, please try again!",alertType = "error")
        }     
      }else {
        varValues$authenticated <- FALSE
        customAlert(message = "Wrong username or password, please try again!",alertType = "error")
      }
    }else{
      customAlert(message = "unable to connect with Login server. Please connect with helpdesk.", alertType = "error")
    }
  })
  
}