#' Update Datasets
#'
#'  Update coronavirus_br, coronavirus_br_states, coronavirus_br_cities, spatial_br_states, spatial_br_cities datasets
#'  Data Sources: https://coronavirus.saude.gov.br/ and https://brasil.io/dateset/coronavirus19/
#'
#' @export
#'
#' @examples
#' \dontrun{
#' update_datasets()
#' }
update_datasets = function(filename=NULL){

  if (is.null(filename)){
    filename = paste0("https://covid.saude.gov.br/assets/files/COVID19_",
                      format(Sys.Date(), "%Y%m%d.csv"))
  }

  cat("Reading https://covid.saude.gov.br dataset\n===========================================\n")

  coronavirus_br_states = NULL
  tryCatch({
    coronavirus_br_states = readr::read_csv2(filename,
                              locale = readr::locale(date_format = "%d/%m/%Y")) %>%
    dplyr::select(date=data, cases=casosAcumulados, deaths=obitosAcumulados, state=estado) %>%
    dplyr::group_by(state) %>%
    dplyr::mutate(delta_cases = cases - dplyr::lag(cases), delta_deaths = deaths - dplyr::lag(deaths)) %>%
    dplyr::filter(date >= "2020-02-25")}, error = function(e) cat("")
  )
  if (is.null(coronavirus_br_states)){
    coronavirus_br_states = readr::read_csv2(paste0("https://covid.saude.gov.br/assets/files/COVID19_",
                                                    format(Sys.Date()-1, "%Y%m%d.csv")),
                                             locale = readr::locale(date_format = "%d/%m/%Y")) %>%
      dplyr::select(date=data, cases=casosAcumulados, deaths=obitosAcumulados, state=estado) %>%
      dplyr::group_by(state) %>%
      dplyr::mutate(delta_cases = cases - dplyr::lag(cases), delta_deaths = deaths - dplyr::lag(deaths)) %>%
      dplyr::filter(date >= "2020-02-25")
  }

  coronavirus_br = coronavirus_br_states %>%
    dplyr::group_by(date) %>%
    dplyr::summarise(cases=sum(cases, na.rm=T), deaths=sum(deaths, na.rm=T)) %>%
    dplyr::mutate(delta_cases = cases - dplyr::lag(cases), delta_deaths = deaths - dplyr::lag(deaths))

  cat("Reading https://brasil.io/dataset/covid19 dataset\n=================================================\n")
  coronavirus_br_cities = "https://brasil.io/dataset/covid19/caso?format=csv" %>%
    readr::read_csv() %>%
    dplyr::filter(place_type=="city") %>%
    dplyr::rename(date=date, state=state, city=city, cases=confirmed, deaths=deaths)

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

  usethis::use_data(spatial_br_states, overwrite = TRUE)
  usethis::use_data(spatial_br_cities, overwrite = TRUE)
  sf::write_sf(spatial_br_states, "data-raw/spatial_br_states.gpkg")
  sf::write_sf(spatial_br_cities, "data-raw/spatial_br_cities.gpkg")

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

  usethis::use_data(coronavirus_br, overwrite = TRUE)
  usethis::use_data(coronavirus_br_states, overwrite = TRUE)
  usethis::use_data(coronavirus_br_cities, overwrite = TRUE)

  coronavirus_br %>% readr::write_csv("data-raw/coronavirus_br.csv")
  coronavirus_br_states %>% readr::write_csv("data-raw/coronavirus_states.csv")
  coronavirus_br_cities %>% readr::write_csv("data-raw/coronavirus_cities.csv")
}
