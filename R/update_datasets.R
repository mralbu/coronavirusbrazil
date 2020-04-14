#' Update Datasets
#'
#'  Update coronavirus_br, coronavirus_br_states, coronavirus_br_cities, spatial_br_states, spatial_br_cities datasets
#'  Data Sources: https://coronavirus.saude.gov.br/ and https://brasil.io/dateset/coronavirus19/
#'  As Ministerio da Saude keeps changing its data format everyday, manual daily adjustments may be necessary
#'
#' @export
#'
#' @examples
#' \dontrun{
#' update_datasets()
#' }
update_datasets = function(filename="data-raw/COVID19_MinisterioDaSaude.csv"){

  if (is.null(filename)){
    filename = paste0("https://covid.saude.gov.br/assets/files/COVID19_",
                      format(Sys.Date(), "%Y%m%d.csv"))
  }

  cat("Reading https://covid.saude.gov.br dataset\n===========================================\n")

  coronavirus_br_states = NULL
  tryCatch({
    coronavirus_br_states = readr::read_csv2(filename,
                              locale = readr::locale(encoding = "latin1", date_format = "%d/%m/%Y")) %>%
      dplyr::select(date=3, cases=5, deaths=7, state=2) %>%
      dplyr::group_by(state) %>%
      dplyr::mutate(new_cases = cases - dplyr::lag(cases), new_deaths = deaths - dplyr::lag(deaths),
                    death_rate = deaths/cases, percent_case_increase = 100 * (cases / dplyr::lag(cases)-1),
                    percent_death_increase = 100 * (deaths / dplyr::lag(deaths) - 1)) %>%
      dplyr::filter(date >= "2020-02-25")}, error = function(e) cat("")
  )
  if (is.null(coronavirus_br_states)){
    coronavirus_br_states = readr::read_csv2(paste0("https://covid.saude.gov.br/assets/files/COVID19_",
                                                    format(Sys.Date()-1, "%Y%m%d.csv")),
                                             locale = readr::locale(date_format = "%d/%m/%Y")) %>%
      dplyr::select(date=data, cases=casosAcumulados, deaths=obitosAcumulados, state=estado) %>%
      dplyr::group_by(state) %>%
      dplyr::mutate(new_cases = cases - dplyr::lag(cases), new_deaths = deaths - dplyr::lag(deaths),
                    death_rate = deaths/cases, percent_case_increase = 100 * (cases / dplyr::lag(cases)-1),
                    percent_death_increase = 100 * (deaths / dplyr::lag(deaths) - 1)) %>%
      dplyr::filter(date >= "2020-02-25")
  }

  coronavirus_br = coronavirus_br_states %>%
    dplyr::group_by(date) %>%
    dplyr::summarise(cases=sum(cases, na.rm=T), deaths=sum(deaths, na.rm=T)) %>%
    dplyr::mutate(new_cases = cases - dplyr::lag(cases), new_deaths = deaths - dplyr::lag(deaths),
                  death_rate = deaths/cases, percent_case_increase = 100 * (cases / dplyr::lag(cases)-1),
                  percent_death_increase = 100 * (deaths / dplyr::lag(deaths) - 1))

  devtools::install_github("RamiKrispin/coronavirus", dependencies = F)

  coronavirus_world = coronavirus::coronavirus %>%
    dplyr::group_by(Country.Region, date, type) %>%
    dplyr::summarize(cases=sum(cases, na.rm=T)) %>%
    tidyr::pivot_wider(names_from = type, values_from = cases) %>%
    dplyr::group_by(Country.Region) %>%
    dplyr::mutate(country=Country.Region, new_cases=confirmed, cases=cumsum(confirmed), new_deaths=death, deaths=cumsum(death),
                  death_rate = deaths/cases, percent_case_increase = 100 * (cases / dplyr::lag(cases)-1),
                  percent_death_increase = 100 * (deaths / dplyr::lag(deaths) - 1)) %>%
    dplyr::ungroup() %>%
    dplyr::select(-Country.Region, -confirmed, -recovered, -death) %>%
    dplyr::filter(country != "Brazil") %>%
    dplyr::bind_rows(coronavirus_br %>% dplyr::mutate(country="Brazil"))

  cat("Reading https://brasil.io/dataset/covid19 dataset\n=================================================\n")
  coronavirus_br_cities = "https://brasil.io/dataset/covid19/caso?format=csv" %>%
    readr::read_csv() %>%
    dplyr::filter(place_type=="city") %>%
    dplyr::rename(date=date, state=state, city=city, cases=confirmed, deaths=deaths) %>%
    dplyr::arrange(city, date) %>%
    dplyr::group_by(city) %>%
    dplyr::mutate(new_cases = cases - dplyr::lag(cases), new_deaths = deaths - dplyr::lag(deaths),
                  death_rate = deaths/cases, percent_case_increase = 100 * (cases / dplyr::lag(cases)-1),
                  percent_death_increase = 100 * (deaths / dplyr::lag(deaths) - 1))

  cat("Reading state and city geometries\n==================================\n")
  spatial_br_states = sf::read_sf("https://raw.githubusercontent.com/fititnt/gis-dataset-brasil/master/uf/topojson/uf.json") %>%
    dplyr::mutate(uf=c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR",
                       "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO")) %>%
    sf::st_centroid() %>%
    dplyr::left_join(coronavirus_br_states %>% dplyr::filter(date==max(date, na.rm=T)), by=c("uf"="state")) %>%
    dplyr::mutate(log_cases = log10(cases), log_deaths = log10(deaths))

  spatial_br_cities = readr::read_csv("https://raw.githubusercontent.com/kelvins/Municipios-Brasileiros/master/csv/municipios.csv") %>%
    dplyr::rename(city=nome) %>%
    dplyr::inner_join(coronavirus_br_cities %>% dplyr::group_by(city) %>% dplyr::filter(date==max(date, na.rm=T))) %>%
    sf::st_as_sf(coords=c("longitude", "latitude")) %>%
    dplyr::select(date, city, cases, deaths, geometry) %>%
    dplyr::mutate(log_cases = log10(cases), log_deaths = log10(deaths))

  spatial_world = sf::read_sf("https://raw.githubusercontent.com/johan/world.geo.json/master/countries.geo.json") %>%
    sf::st_centroid() %>%
    dplyr::select(country=name) %>%
    dplyr::filter(country!="United States of America") %>%
    dplyr::mutate(country=ifelse(country=="South Korea", "Korea, South", country)) %>%
    dplyr::mutate(country=ifelse(country=="United Republic of Tanzania", "Tanzania", country)) %>%
    dplyr::mutate(country=ifelse(country=="Democratic Republic of the Congo", "Congo (Kinshasa)", country)) %>%
    dplyr::mutate(country=ifelse(country=="Republic of the Congo", "Congo (Brazzaville)", country)) %>%
    dplyr::mutate(country=ifelse(country=="Taiwan", "Taiwan*", country)) %>%
    dplyr::mutate(country=ifelse(country=="Czech Republic", "Czechia", country)) %>%
    rbind(sf::st_sf(country="US", geometry = sf::st_sfc(sf::st_point(c(-96, 39))), crs = sf::st_crs(.))) %>%
    dplyr::inner_join(coronavirus_world %>%
                        dplyr::group_by(country) %>%
                        dplyr::top_n(1, wt=date) %>%
                        dplyr::ungroup() %>%
                        dplyr::select(country, cases, deaths) %>%
                        dplyr::mutate(log_cases=log10(cases), log_deaths=log10(deaths))
    )

  usethis::use_data(spatial_br_states, overwrite = TRUE)
  usethis::use_data(spatial_br_cities, overwrite = TRUE)
  usethis::use_data(spatial_world, overwrite = TRUE)
  sf::write_sf(spatial_br_states, "data-raw/spatial_br_states.gpkg")
  sf::write_sf(spatial_br_cities, "data-raw/spatial_br_cities.gpkg")
  sf::write_sf(spatial_world, "data-raw/spatial_world.gpkg")

  date_gt_100_df = coronavirus_br %>%
    dplyr::arrange(date) %>%
    dplyr::filter(cases >= 100) %>%
    dplyr::summarise(date_gt_100=min(date))
  date_gt_10_df = coronavirus_br %>%
    dplyr::arrange(date) %>%
    dplyr::filter(cases >= 10) %>%
    dplyr::summarise(date_gt_10=min(date))

  coronavirus_br = coronavirus_br %>%
    dplyr::mutate(date_gt_10 = date_gt_10_df$date_gt_10, date_gt_100 = date_gt_100_df$date_gt_100) %>%
    dplyr::mutate(days_gt_10 = ifelse(date >= date_gt_10, date - date_gt_10, NA),
                  days_gt_100 = ifelse(date >= date_gt_100, date - date_gt_100, NA)) %>%
    dplyr::select(-date_gt_10, -date_gt_100)

  date_gt_100_df = coronavirus_world %>%
    dplyr::group_by(country) %>%
    dplyr::arrange(date) %>%
    dplyr::filter(cases >= 100) %>%
    dplyr::summarise(date_gt_100=min(date)) %>%
    dplyr::ungroup()
  date_gt_10_df = coronavirus_world %>%
    dplyr::group_by(country) %>%
    dplyr::arrange(date) %>%
    dplyr::filter(cases >= 10) %>%
    dplyr::summarise(date_gt_10=min(date)) %>%
    dplyr::ungroup()

  coronavirus_world = coronavirus_world %>%
    dplyr::left_join(date_gt_100_df) %>%
    dplyr::left_join(date_gt_10_df) %>%
    dplyr::mutate(days_gt_10 = ifelse(date >= date_gt_10, date - date_gt_10, NA),
                  days_gt_100 = ifelse(date >= date_gt_100, date - date_gt_100, NA)) %>%
    dplyr::select(-date_gt_10, -date_gt_100)

  coronavirus_br_states = coronavirus_br_states %>%
    dplyr::arrange(state, date) %>%
    dplyr::group_by(state) %>%
    dplyr::filter(cases >= 100) %>%
    dplyr::summarise(date_gt_100=min(date)) %>%
    dplyr::right_join(coronavirus_br_states) %>%
    dplyr::arrange(state, date) %>%
    dplyr::group_by(state, date_gt_100) %>%
    dplyr::filter(cases >= 10) %>%
    dplyr::summarise(date_gt_10=min(date)) %>%
    dplyr::right_join(coronavirus_br_states) %>%
    dplyr::mutate(days_gt_10 = ifelse(date >= date_gt_10, date - date_gt_10, NA),
                  days_gt_100 = ifelse(date >= date_gt_100, date - date_gt_100, NA)) %>%
    dplyr::select(-date_gt_10, -date_gt_100)

  coronavirus_br_cities = coronavirus_br_cities %>%
    dplyr::arrange(city, date) %>%
    dplyr::group_by(city) %>%
    dplyr::filter(cases >= 100) %>%
    dplyr::summarise(date_gt_100=min(date)) %>%
    dplyr::right_join(coronavirus_br_cities) %>%
    dplyr::arrange(city, date) %>%
    dplyr::group_by(city, date_gt_100) %>%
    dplyr::filter(cases >= 10) %>%
    dplyr::summarise(date_gt_10=min(date)) %>%
    dplyr::right_join(coronavirus_br_cities) %>%
    dplyr::mutate(days_gt_10 = ifelse(date >= date_gt_10, date - date_gt_10, NA),
                  days_gt_100 = ifelse(date >= date_gt_100, date - date_gt_100, NA)) %>%
    dplyr::select(-date_gt_10, -date_gt_100)

  usethis::use_data(coronavirus_br, overwrite = TRUE)
  usethis::use_data(coronavirus_world, overwrite = TRUE)
  usethis::use_data(coronavirus_br_states, overwrite = TRUE)
  usethis::use_data(coronavirus_br_cities, overwrite = TRUE)

  coronavirus_br %>% readr::write_csv("data-raw/coronavirus_br.csv")
  coronavirus_world %>% readr::write_csv("data-raw/coronavirus_world.csv")
  coronavirus_br_states %>% readr::write_csv("data-raw/coronavirus_states.csv")
  coronavirus_br_cities %>% readr::write_csv("data-raw/coronavirus_cities.csv")

  cat("Reading http://painel.saude.rj.gov.br/monitoramento/covid19.html dataset\n=================================================\n")

  spatial_rj_neighborhoods = "https://services1.arcgis.com/OlP4dGNtIcnD3RYf/ArcGIS/rest/services/Casos_bairros_2/FeatureServer/0" %>%
    esri2sf::esri2sf() %>%
    dplyr::rename(neighborhood=Bairro, cases=Confirmados, deaths=Óbitos, lat=Lat, lon=Long) %>%
    dplyr::mutate(log_cases=log10(cases), log_deaths=log10(deaths))

  coronavirus_rj_case_metadata = "https://services1.arcgis.com/OlP4dGNtIcnD3RYf/ArcGIS/rest/services/Casos_individuais_3/FeatureServer/0" %>%
    esri2sf::esri2sf(geomType="esriGeometryPolygon") %>%
    dplyr::as_tibble() %>%
    dplyr::select(-geoms) %>%
    dplyr::mutate(dt_notific=as.Date(dt_notific, format="%d/%m/%Y"),
                  dt_is=as.Date(dt_is, format="%d/%m/%Y"),
                  hospitalizações=dplyr::recode(hospitalizações, S=TRUE, N=FALSE, `N/D`=NA),
                  uti=dplyr::recode(uti, S=TRUE, N=FALSE, `N/D`=NA),
                  óbitos=dplyr::recode(óbitos, S=TRUE, N=FALSE, `N/D`=NA))

  coronavirus_rj_case_metadata %>% readr::write_csv("data-raw/coronavirus_rj_case_metadata.csv")
  spatial_rj_neighborhoods %>% sf::write_sf("data-raw/spatial_rj_neighborhoods.gpkg")

  usethis::use_data(coronavirus_rj_case_metadata, overwrite = TRUE)
  usethis::use_data(spatial_rj_neighborhoods, overwrite = TRUE)
}
