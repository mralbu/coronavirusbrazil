# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp(appName="covid19viz")
# Or use the blue button on top of this file

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
coronavirusbrazil::run_app()
