
#' plot_coronavirus
#'
#' @param coronavirus_br Dataset
#' @param xaxis xaxis variable ("cases" | "date" | "days_gt_10" | "days_gt_100")
#' @param yaxis yaxis variabel ("cases" | "deaths" | "new_cases" | "new_deaths" | "death_rate")
#' @param color coloring data.frame variable
#' @param filter_variable variable to be filtered
#' @param filter_values filtering values
#' @param log_scale plot on log scale?
#' @param smooth plot smooth?
#' @param facet variable to be used for facetting
#'
#' @return
#' @export
plot_coronavirus = function(coronavirus_br, xaxis="date", yaxis="cases",
                            color=NULL, log_scale=FALSE, smooth=FALSE,
                            filter_variable=NULL, filter_values=NULL, facet=NA){

  # Create yaxis_label and xaxis_label
  yaxis_dict = list(cases = "Casos Acumulados", deaths = "Mortes Acumuladas", new_cases = "Variacao de Casos", new_deaths = "Variacao de Mortes", death_rate = "Mortalidade", percent_case_increase = "Variação Percentual de Casos (%)", percent_death_increase = "Variação Percentual de Mortes (%)")
  yaxis_label = yaxis_dict[[yaxis]]

  xaxis_dict = list(cases = "Casos Acumulados", date = "Data", days_gt_10 = "Dias depois de 10 Casos", days_gt_100 = "Dias depois de 100 Casos")
  xaxis_label = xaxis_dict[[xaxis]]

  if (!is.null(color)){
    color_dict = list(state = "", city = "")
    color_label = color_dict[[color]]
  }

  # Filter dates for death related cases
  df_ = dplyr::filter(coronavirus_br, !!as.symbol(yaxis) > 0)

  if (!is.null(filter_values)) df_ = dplyr::filter(df_, !!as.symbol(filter_variable) %in% filter_values) else df_ = df_

  if (is.null(color)){
    g = df_ %>%
      dplyr::group_by(!!as.symbol(color)) %>%
      dplyr::mutate(roll_mean=zoo::rollmean(!!as.symbol(yaxis), 7, na.pad = TRUE)) %>%
      ggplot2::ggplot(ggplot2::aes_string(xaxis, yaxis)) + ggplot2::geom_point(alpha=0.5) + geom_line(aes(y=roll_mean), size=2) +
      ggplot2::xlab(xaxis_label) + ggplot2::ylab(yaxis_label) + ggplot2::ylim(0, NA)
  } else {
    g = df_ %>%
        dplyr::mutate(roll_mean=zoo::rollmean(!!as.symbol(yaxis), 7, na.pad = TRUE)) %>%
        ggplot2::ggplot(ggplot2::aes_string(xaxis, yaxis, color=color)) + ggplot2::geom_point(alpha=0.5) + geom_line(aes(y=roll_mean), size=2) +
        ggplot2::xlab(xaxis_label) + ggplot2::ylab(yaxis_label) + ggplot2::ylim(0, NA) + ggplot2::scale_color_discrete(color_label)
  }

  if (log_scale) g = g + ggplot2::scale_y_log10()
  if (smooth) g = g + ggplot2::stat_smooth()
  if (xaxis == "cases") g = g + ggplot2::scale_x_log10() + ggplot2::xlab(ifelse(xaxis=="cases", "Casos Acumulados", "Mortes"))
  if (!is.null(facet) & !is.na(facet) & !is.null(filter_values)) g = g + ggplot2::facet_wrap({facet})

  g
}
