############# clearing env before launching APP  #############
rm(list = ls())

##### Setting the shiny options #####
options(shiny.maxRequestSize = 50*1024^2, # setting maximum upload size to 50MB if required.
        scipen = 999 # disable scientific notation
        )

##### Setting the Rtool path #####
Sys.setenv("R_ZIPCMD" = "C:/Rtools/bin/zip.exe")

############ loading required libraries  #############
library(shiny)            # used to shiny APP
library(shinydashboard)

