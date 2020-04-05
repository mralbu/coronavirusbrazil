
#' Run Shiny App
#'
#' @export
run_app = function(){
  shiny::shinyAppDir(system.file("app", package="coronavirusbrazil"))
}
