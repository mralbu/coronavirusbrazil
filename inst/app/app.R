
if (!require(coronavirusbrazil)) remotes::install_github("mralbu/coronavirusbrazil")

shiny::shinyApp(coronavirusbrazil::app_ui(), coronavirusbrazil:::app_server)
