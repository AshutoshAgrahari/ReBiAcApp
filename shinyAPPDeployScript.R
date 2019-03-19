
# This Script is required to deploy Retailify Application over shinyApps.io
library(rsconnect)

rsconnect::setAccountInfo(name='alexnimbush', 
                          token='1B145E6A7A41B653EA9C3EE4895A5939', 
                          secret='kNJTaeAqBRJ//JSlsSbfjp6zLPQfj2miGr6U+rDB')



rsconnect::deployApp(getwd())
