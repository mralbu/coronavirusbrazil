
#' Shiny app server
#'
#' @return
#' @export
#'
app_server = function(input, output) {
  output$plot_country <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus(coronavirusbrazil::coronavirus_br, input$xaxis_br, input$yaxis_br,
                                            log_scale=input$log_scale_br, linear_smooth=input$linear_smooth_br)
    g %>% plotly::ggplotly()
  })

  output$plot_states <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus(coronavirusbrazil::coronavirus_br_states,
                                            input$xaxis_states, input$yaxis_states, color="state",
                                            log_scale=input$log_scale_states, linear_smooth=input$linear_smooth_states,
                                            filter_variable="state", filter_values=input$filter_uf_states,
                                            facet=dplyr::if_else(input$facet_uf_states, "state", NULL))
    g %>% plotly::ggplotly()
  })

  output$plot_cities <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus(coronavirusbrazil::coronavirus_br_cities,
                                            input$xaxis_cities, input$yaxis_cities, color="city",
                                            log_scale=input$log_scale_cities, linear_smooth=input$linear_smooth_cities,
                                            filter_variable="city", filter_values=input$filter_cities,
                                            facet=dplyr::if_else(input$facet_cities, "city", NULL))
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
                                  ": ", coronavirusbrazil::spatial_br_states$deaths))
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
