
#' Shiny app server
#'
#' @return
#' @export
#'
app_server = function(input, output) {
  output$plot_country <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus_br(coronavirusbrazil::coronavirus_br, input$xaxis_br, input$what_br, input$delta_br, input$log_scale_br, input$tendency_br)
    g %>% plotly::ggplotly()
  })

  output$plot_states <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus_states(coronavirusbrazil::coronavirus_br_states, input$xaxis, input$what, input$filter_uf, input$delta, input$log_scale, input$facet_uf, input$tendency)

    g %>% plotly::ggplotly()
  })

  output$map_cases_states = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_br_states, zcol="cases", cex="log_cases", alpha=1,
                     col.regions=viridisLite::viridis(n=256,
                                                      alpha=0.1,
                                                      direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     layer.name="Casos",
                     label=paste0(coronavirusbrazil::spatial_br_states$uf,
                                  ": ", coronavirusbrazil::spatial_br_states$cases))
  )

  output$map_deaths_states = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_br_states, zcol="deaths", cex="log_deaths", alpha=1,
                     col.regions=viridisLite::viridis(n=256,
                                                      alpha=0.1,
                                                      direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     layer.name="Mortes",
                     label=paste0(coronavirusbrazil::spatial_br_states$uf,
                                  ": ", coronavirusbrazil::spatial_br_states$mortes))
  )

  output$map_cases_cities = mapview::renderMapview(
    mapview::mapview((coronavirusbrazil::spatial_br_cities %>% dplyr::filter(cases > 0)), zcol="cases", cex="log_cases", alpha=1,
                     col.regions=viridisLite::viridis(n=256,
                                                      alpha=0.1,
                                                      direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     layer.name="Casos",
                     label=paste0((coronavirusbrazil::spatial_br_cities %>% dplyr::filter(cases > 0))$city,
                                  ": ", (coronavirusbrazil::spatial_br_cities %>% dplyr::filter(cases > 0))$cases))
  )

  output$map_deaths_cities = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_br_cities %>% dplyr::filter(deaths > 0), zcol="deaths", cex="log_deaths", alpha=1,
                     col.regions=viridisLite::viridis(n=256,
                                                      alpha=0.1,
                                                      direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     layer.name="Mortes",
                     label=paste0((coronavirusbrazil::spatial_br_cities %>% dplyr::filter(deaths > 0))$city, ": ", (coronavirusbrazil::spatial_br_cities %>% dplyr::filter(deaths > 0))$deaths))
  )

}
