#' The Coronavirus COVID-19 Brazil Dataset
#'
#' @description  Daily summary of the Coronavirus (COVID-19) cases in Brazil
#'
#' @format A data.frame object
#' \describe{
#'   \item{date}{Date}
#'   \item{cases}{Confirmed Cases}
#'   \item{deaths}{Deaths}
#'   \item{new_cases}{Confirmed Cases daily variation}
#'   \item{new_deaths}{Deaths daily variation}
#'   \item{days_gt_10}{Days since 10th Confirmed Case}
#'   \item{days_gt_100}{Days since 100th Confirmed Case}
#'   \item{death_rate}{Confirmed Cases / Deaths}
#'   \item{percent_case_increase}{Percentage daily increase in cases}
#'   \item{percent_death_increase}{Percentage daily increase in deaths}
#' }
#' @source \href{https://covid.saude.gov.br}{Ministerio da Saude}
#' @keywords datasets coronavirus_br COVID19
#' @details The dataset contains the daily summary of Coronavirus cases (confirmed cases and deaths) in brazil
#' @examples
#'
#' data(coronavirus_br)
#'
"coronavirus_br"

#' The Coronavirus COVID-19 Brazil Dataset by state
#'
#' @description  Daily summary of the Coronavirus (COVID-19) cases in Brazil by state
#'
#' @format A data.frame object
#' \describe{
#'   \item{date}{Date}
#'   \item{state}{Brazilian state}
#'   \item{cases}{Confirmed Cases}
#'   \item{deaths}{Deaths}
#'   \item{new_cases}{Confirmed Cases daily variation}
#'   \item{new_deaths}{Deaths daily variation}
#'   \item{days_gt_10}{Days since 10th Confirmed Case}
#'   \item{days_gt_100}{Days since 100th Confirmed Case}
#'   \item{death_rate}{Confirmed Cases / Deaths}
#'   \item{percent_case_increase}{Percentage daily increase in cases}
#'   \item{percent_death_increase}{Percentage daily increase in deaths}
#' }
#' @source \href{https://covid.saude.gov.br}{Ministerio da Saude}
#' @keywords datasets coronavirus_br COVID19
#' @details The dataset contains the daily summary of Coronavirus cases (confirmed cases and deaths) in brazil
#' @examples
#'
#' data(coronavirus_br_states)
#'
"coronavirus_br_states"

#' The Coronavirus COVID-19 Brazil Dataset by state
#'
#' @description  Daily summary of the Coronavirus (COVID-19) cases in Brazil by state
#'
#' @format A data.frame object
#' \describe{
#'   \item{date}{Date}
#'   \item{state}{Brazilian state}
#'   \item{cases}{Confirmed Cases}
#'   \item{deaths}{Deaths}
#'   \item{new_cases}{Confirmed Cases daily variation}
#'   \item{new_deaths}{Deaths daily variation}
#'   \item{days_gt_10}{Days since 10th Confirmed Case}
#'   \item{days_gt_100}{Days since 100th Confirmed Case}
#'   \item{death_rate}{Confirmed Cases / Deaths}
#'   \item{percent_case_increase}{Percentage daily increase in cases}
#'   \item{percent_death_increase}{Percentage daily increase in deaths}
#' }
#' @source \href{https://brasil.io/dataset/covid19/}{brasil.io}
#' @keywords datasets coronavirus_br COVID19
#' @details The dataset contains the daily summary of Coronavirus cases (confirmed cases and deaths) in brazil
#' @examples
#'
#' data(coronavirus_br_cities)
#'
"coronavirus_br_cities"

#' Rio de Janeiro COVID-19 cases
#'
#' @description  Metadata of the Rio de Janeiro COVID-19 cases
#'
#' @format data.frame object
#' \describe{
#'   \item{bairro_resid__estadia}{Rio de Janeiro Neighborhood}
#'   \item{classificação_final}{Final Classification}
#'   \item{dt_notific}{Notification date}
#'   \item{ap__residencia}{AP of the patient residence}
#'   \item{idade}{age}
#'   \item{sexo}{sex}
#'   \item{ObjectId2}{objectId2}
#'   \item{sexo}{sex}
#'   \item{faixa_etária}{age range}
#'   \item{hospitalizações}{hospitalization}
#'   \item{uti}{Intensive Care Unit}
#'   \item{óbitos}{deaths}
#'   \item{hist_desloc}{sex}
#'   \item{dt_is}{sex}
#'   \item{tp_gestao}{Management Kind}
#'   \item{tipo_municipal}{Municipal Management}
#' }
#' @source \href{http://painel.saude.rj.gov.br/monitoramento/covid19.html}{Secretaria de Saúde - RJ}
#' @keywords datasets coronavirus_br COVID19
#' @details Metadata of the Rio de Janeiro COVID-19 cases
#' @examples
#'
#' data(coronavirus_rj_case_metadata)
#'
"coronavirus_rj_case_metadata"

#' Spatial Dataset of Rio de Janeiro cases by neighborhood
#'
#' @description  Spatial summary of the Coronavirus (COVID-19) cases in Rio de Janeiro neighborhoods
#'
#' @format A spatial data.frame object (sf)
#' \describe{
#'   \item{neighborhood}{Rio de Janeiro Neighborhood}
#'   \item{cases}{Confirmed Cases}
#'   \item{lat}{Latitude}
#'   \item{lon}{Longitude}
#'   \item{AP}{AP}
#'   \item{objectId}{objectId}
#'   \item{geoms}{Simple Features geometries}
#' }
#' @source \href{http://painel.saude.rj.gov.br/monitoramento/covid19.html}{Secretaria de Saúde - RJ}
#' @keywords datasets coronavirus_br COVID19
#' @details The spatial dataset contains cases of covid-19 in Rio de Janeiro neighborhoods
#' @examples
#'
#' data(spatial_rj_neighborhoods)
#'
"spatial_rj_neighborhoods"

#' Spatial Dataset of Brazilian Cases by state
#'
#' @description  Spatial summary of the Coronavirus (COVID-19) cases in Brazilian states
#'
#' @format A spatial data.frame object (sf)
#' \describe{
#'   \item{city}{City}
#'   \item{date}Date}
#'   \item{cases}{Confirmed COVID-19 cases}
#'   \item{deaths}{COVID-19 deaths}
#'   \item{geoms}{Simple Features geometries}
#' }
#' @source \href{https://brasil.io/dataset/covid19/}{brasil.io}
#' @keywords datasets coronavirus_br COVID19
#' @details The spatial dataset contains cases of covid-19 in Brazilian cities
#' @examples
#'
#' data(spatial_br_cities)
#'
"spatial_br_cities"

#' Spatial Dataset of Brazilian Cases by state
#'
#' @description  Spatial summary of the Coronavirus (COVID-19) cases in Brazilian states
#'
#' @format A spatial data.frame object (sf)
#' \describe{
#'   \item{uf}{state}
#'   \item{date}Date}
#'   \item{cases}{Confirmed COVID-19 cases}
#'   \item{deaths}{COVID-19 deaths}
#'   \item{geoms}{Simple Features geometries}
#' }
#' @source \href{https://covid.saude.gov.br}{Ministerio da Saude}
#' @keywords datasets coronavirus_br COVID19
#' @details The spatial dataset contains cases of covid-19 in Brazilian states
#' @examples
#'
#' data(spatial_br_states)
#'
"spatial_br_states"
