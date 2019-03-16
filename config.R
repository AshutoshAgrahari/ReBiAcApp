list.of.packages <- c(
  "shiny","shinydashboard","devtools","shinyjs","shinyBS","shinyalert","V8"
)


new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages))
  install.packages(new.packages, repos='http://cran.us.r-project.org',dependencies = T)

library(devtools)
install_github("nik01010/dashboardthemes")
