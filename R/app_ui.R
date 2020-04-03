
#' Shiny app ui
#'
#' @return
#' @export
#'
app_ui = function() {

  shiny::navbarPage("Covid-19 BR Viz", theme = shinythemes::shinytheme("cosmo"),
    shiny::tabPanel("Brasil",
            shiny::sidebarLayout(
              shiny::sidebarPanel(
                shiny::selectInput("what_br", "Variável", choices = list(Casos="cases", Mortes="deaths")),
                shiny::selectInput("xaxis_br", "Eixo X", choices = list(Data="date", `Dias depois de 10 Casos`="days_gt_10",
                                                                        `Dias depois de 100 Casos`="days_gt_100", `Casos Acumulados`="cases")),
                shiny::checkboxInput("log_scale_br", "Escala Log"),
                shiny::checkboxInput("delta_br", "Variação Diária"),
                shiny::checkboxInput("tendency_br", "Tendência")
               ),
              shiny::mainPanel(
                 plotly::plotlyOutput("plot_country")
               )
             )
    ),
      shiny::tabPanel("Estados",
        shiny::sidebarLayout(
          shiny::sidebarPanel(
            shiny::selectInput("what", "Variável", choices = list(Casos="cases", Mortes="deaths")),
            shiny::selectInput("xaxis", "Eixo X", choices = list(Data="date", `Dias depois de 10 Casos`="days_gt_10",
                                                                 `Dias depois de 100 Casos`="days_gt_100", `Casos Acumulados`="cases")),
            shiny::selectInput("filter_uf", "Estados", multiple = TRUE, choices = sort(unique(coronavirusbrazil::coronavirus_br_states$state)), selected = c("SP", "RJ")),
            shiny::checkboxInput("log_scale", "Escala Log", value = TRUE),
            shiny::checkboxInput("facet_uf", "Gráficos Individuais", value = TRUE),
            shiny::checkboxInput("delta", "Variação Diária"),
            shiny::checkboxInput("tendency", "Tendência")
               ),
          shiny::mainPanel(
            plotly::plotlyOutput("plot_states")
          )
        )
    ),
    shiny::tabPanel("Mapa",
      shiny::tabsetPanel(
        shiny::tabPanel("Estados",
          shiny::tabsetPanel(
            shiny::tabPanel("Casos", mapview::mapviewOutput("map_cases_states")),
            shiny::tabPanel("Mortes",  mapview::mapviewOutput("map_deaths_states"))
          )
        ),
        shiny::tabPanel("Cidades",
          shiny::tabsetPanel(
            shiny::tabPanel("Casos", mapview::mapviewOutput("map_cases_cities")),
            shiny::tabPanel("Mortes",  mapview::mapviewOutput("map_deaths_cities"))
          )
        )
      )
    ),
    shiny::tabPanel("Sobre",
      shiny::includeMarkdown("Sobre.md")
    )
  )
}
