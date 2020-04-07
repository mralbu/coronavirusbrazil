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
