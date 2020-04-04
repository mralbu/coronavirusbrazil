
#' Run Shiny App
#'
#' @export
run_coronavirusbrazil_app = function(){
  shiny::shinyAppDir(system.file("app", package="coronavirusbrazil"))
}
