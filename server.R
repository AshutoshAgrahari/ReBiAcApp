function(input, output, session){
  observeEvent(input$login,{
    showModal(fnLoginModal())
  })
  
  # kfnLoginModal returns UI as Modaldialog popup for user login
  fnLoginModal <- function(failed = FALSE) {
    modalDialog(title = tags$b("User Login"),size = "m",easyClose = T,fade = T,
                wellPanel(
                  textInput("usernameInput", "Username:",placeholder = "Provide username",width = "100%"),
                  passwordInput("passwordInput", "Password:",placeholder = "Provide password",width = "100%")
                ),
                actionButton("actLogin", "Login",class = "button button1"),
                footer = NULL, class = "modal-header modal-title modal-content modal-body"
    )
  }
  
  # When Login button is clicked, attempt to authenticate user. If successful remove the login modal. 
  varValues <- reactiveValues(authenticated = FALSE)
  
  # validate user login detail
  observe({
    req(input$kacLogin)
    isolate({
      Username <- input$kinUsername
      Password <- input$kinPassword
    })
    
    Id.username <- which(KARMALoginRegister$username == Username)
    Id.password <- which(KARMALoginRegister$password == Password)
    if (length(Id.username) > 0 & length(Id.password) > 0) {
      if (Id.username == Id.password) {
        Logged <<- TRUE
        kvarvalues$authenticated <- TRUE
        removeModal()
        karmaMasterList[["UserName"]] <<- input$kinUsername
        meCustomAlert("Welcome to KARMA", alertType = "success")
        
        userProjectDir <<- paste0(KARMA_MLWB_APPData,"/",Username)
        # create user dir in AppData if it is not exist to save model.
        if(!dir.exists(userProjectDir)){
          dir.create(userProjectDir)
        }
        
        ## Projects Registry of User
        # List of save projects by logged user, KARMAProjectModelRegister: It is a registry of Analyst-project-model.
        UserProjectRegistry <- paste0(userProjectDir,"/KARMAProjectModelRegister.RData")
        if(file.exists(UserProjectRegistry)){
          load(UserProjectRegistry,envir = .GlobalEnv)
        }else{
          KARMAProjectModelRegister <<- data.frame(matrix(ncol = 6, nrow = 0))
          names(KARMAProjectModelRegister) <<- c("Index","UserName","ProjectRunID","ProjectName","CreationDate","CurrentStatus")
        }
        
        ## output panel to display logged user in sidebar menu
        output$logoutUI <- renderUI({
          tagList(
            actionButton("HomeButton",label = tags$b("Home"),style="color: #FFCC00; background-color: #000000;margin: 8px"),
            actionButton("SaveButton",label = tags$b("Save Project"),style="color: #FFCC00; background-color: #000000; margin: 8px"),
            actionButton("Logout", label = tags$b("Logout"),style="color: #FFCC00; background-color: #000000; margin: 8px")
          )
        })
        
      } else {
        kvarvalues$authenticated <- FALSE
        meCustomAlert(message = "Wrong username or password, please try again.",alertType = "error")
      }     
    }else {
      meCustomAlert(message = "Wrong username or password, please try again.",alertType = "error")
    }
  })
  
}