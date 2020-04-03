#' The Coronavirus COVID-19 Brazil Dataset
#'
#' @description  Daily summary of the Coronavirus (COVID-19) cases in Brazil
#'
#' @format A data.frame object
#' \describe{
#'   \item{date}{Date}
#'   \item{cases}{Confirmed Cases}
#'   \item{deaths}{Deaths}
#'   \item{delta_cases}{Confirmed Cases daily variation}
#'   \item{delta_deaths}{Deaths daily variation}
#'   \item{days_gt_10}{Days since 10th Confirmed Case}
#'   \item{delta_deaths}{Days since 100th Confirmed Case}
#' }
#' @source \href{https://covid.saude.gov.br}{Ministerio da Saude} and \href{https://brasil.io/dataset/covid19/}{brasil.io}
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
#'   \item{delta_cases}{Confirmed Cases daily variation}
#'   \item{delta_deaths}{Deaths daily variation}
#'   \item{days_gt_10}{Days since 10th Confirmed Case}
#'   \item{delta_deaths}{Days since 100th Confirmed Case}
#' }
#' @source \href{https://covid.saude.gov.br}{Ministerio da Saude} and \href{https://brasil.io/dataset/covid19/}{brasil.io}
#' @keywords datasets coronavirus_br COVID19
#' @details The dataset contains the daily summary of Coronavirus cases (confirmed cases and deaths) in brazil
#' @examples
#'
#' data(coronavirus_br_states)
#'
"coronavirus_br_states"
