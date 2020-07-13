
#' Shiny app server
#'
#' @return
#' @export
#'
app_server = function(input, output) {

  output$plot_countries <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus(coronavirusbrazil::coronavirus_world,
                                            input$xaxis_world, input$yaxis_world, color="country",
                                            log_scale=input$log_scale_world, smooth=input$linear_smooth_world,
                                            filter_variable="country", filter_values=input$filter_country_world,
                                            facet=dplyr::if_else(input$facet_country_world, "country", NULL))
    g %>% plotly::ggplotly()
  })

  output$plot_states <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus(coronavirusbrazil::coronavirus_br_states,
                                            input$xaxis_states, input$yaxis_states, color="state",
                                            log_scale=input$log_scale_states, smooth=input$linear_smooth_states,
                                            filter_variable="state", filter_values=input$filter_uf_states,
                                            facet=dplyr::if_else(input$facet_uf_states, "state",  NULL))
    g %>% plotly::ggplotly()
  })

  output$plot_cities <- plotly::renderPlotly({

    g = coronavirusbrazil::plot_coronavirus(coronavirusbrazil::coronavirus_br_cities,
                                            input$xaxis_cities, input$yaxis_cities, color="city",
                                            log_scale=input$log_scale_cities, smooth=input$linear_smooth_cities,
                                            filter_variable="city", filter_values=input$filter_cities,
                                            facet=dplyr::if_else(input$facet_cities, "city",  NULL))
    g %>% plotly::ggplotly()
  })

  output$map_cases_countries = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_world, zcol="log_cases", cex="log_cases", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles(),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Casos",
                     label=paste0(coronavirusbrazil::spatial_world$country,
                                  ": ", coronavirusbrazil::spatial_world$cases))
  )

  output$map_deaths_countries = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_world %>% dplyr::filter(deaths > 0), zcol="log_deaths", cex="log_deaths", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles(),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Mortes",
                     label=paste0((coronavirusbrazil::spatial_world %>% dplyr::filter(deaths > 0))$country,
                                  ": ", (coronavirusbrazil::spatial_world %>% dplyr::filter(deaths > 0))$deaths))
  )

  output$map_cases_states = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_br_states, zcol="log_cases", cex="log_cases", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Casos",
                     label=paste0(coronavirusbrazil::spatial_br_states$uf,
                                  ": ", coronavirusbrazil::spatial_br_states$cases))
  )

  output$map_deaths_states = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_br_states, zcol="log_deaths", cex="log_deaths", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Mortes",
                     label=paste0(coronavirusbrazil::spatial_br_states$uf,
                                  ": ", coronavirusbrazil::spatial_br_states$deaths))
  )

  output$map_cases_cities = mapview::renderMapview(
    mapview::mapview((coronavirusbrazil::spatial_br_cities %>% dplyr::filter(cases > 0) %>% dplyr::mutate(log_cases = log10(cases), log_deaths = log10(deaths))), zcol="log_cases", cex="log_cases", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Casos",
                     label=paste0((coronavirusbrazil::spatial_br_cities %>% dplyr::filter(cases > 0))$city,
                                  ": ", (coronavirusbrazil::spatial_br_cities %>% dplyr::filter(cases > 0))$cases))
  )

  output$map_deaths_cities = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_br_cities %>% dplyr::filter(deaths > 0) %>% dplyr::mutate(log_cases = log10(cases), log_deaths = log10(deaths)), zcol="log_deaths", cex="log_deaths", alpha=1,
                     col.regions=viridisLite::viridis(n=256,
                                                      alpha=0.1,
                                                      direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles() %>%
                       leaflet::setView(-60, -18, zoom=3),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Mortes",
                     label=paste0((coronavirusbrazil::spatial_br_cities %>% dplyr::filter(deaths > 0))$city, ": ", (coronavirusbrazil::spatial_br_cities %>% dplyr::filter(deaths > 0))$deaths))
  )

  output$map_cases_rj = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_rj_neighborhoods %>% dplyr::filter(lon < -30, cases > 0), zcol="log_cases", cex="log_cases", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles(),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Casos",
                     label=paste0((coronavirusbrazil::spatial_rj_neighborhoods %>% dplyr::filter(lon < -30, cases > 0))$neighborhood, ": ", (coronavirusbrazil::spatial_rj_neighborhoods %>% dplyr::filter(lon < -30, cases > 0))$cases))
  )

  output$map_deaths_rj = mapview::renderMapview(
    mapview::mapview(coronavirusbrazil::spatial_rj_neighborhoods %>% dplyr::filter(lon < -30, deaths > 0), zcol="log_deaths", cex="log_deaths", alpha=1,
                     # col.regions=viridisLite::viridis(n=256,
                     #                                  alpha=0.1,
                     #                                  direction=1),
                     map = leaflet::leaflet() %>% leaflet::addTiles(),
                     popup=NULL,
                     legend=FALSE,
                     layer.name="Mortes",
                     label=paste0((coronavirusbrazil::spatial_rj_neighborhoods %>% dplyr::filter(lon < -30, deaths > 0))$neighborhood, ": ", (coronavirusbrazil::spatial_rj_neighborhoods %>% dplyr::filter(lon < -30, deaths > 0))$deaths))
  )

}
