
### List of Libraries which needs to install from CRAN repository.
list.of.packages <- c(
  "shiny","shinydashboard","devtools","shinyjs","shinyBS","shinyalert","V8","data.table",
  "dplyr","tidyverse","readxl","openxlsx","rhandsontable","rsconnect"
)

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages))
  install.packages(new.packages, repos='http://cran.us.r-project.org',dependencies = F)


### List of libraries which needs to install from GIT repository.
list.of.packages <- c("dashboardthemes")

new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)){
  library(devtools)
  install_github("nik01010/dashboardthemes")
}
  



