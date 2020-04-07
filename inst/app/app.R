
pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
shiny::shinyApp(coronavirusbrazil::app_ui(), coronavirusbrazil:::app_server)
