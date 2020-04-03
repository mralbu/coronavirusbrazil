
#' plot_coronavirus_br
#'
#' @param coronavirus_br Dataset
#' @param xaxis_br xaxis variable
#' @param what_br yaxis variabel
#' @param delta_br plot variation?
#' @param log_scale_br plot on log scale?
#' @param tendency_br plot line tendency?
#'
#' @return
#' @export
plot_coronavirus_br = function(coronavirus_br, xaxis_br="date", what_br="cases",
                         delta_br=FALSE, log_scale_br=FALSE, tendency_br=FALSE){

  # Create what_br_label and xaxis_br_label
  what_br_dict = list(Casos="cases", Mortes="deaths")
  what_br_dict = split(names(what_br_dict), unlist(what_br_dict))
  what_br_label = what_br_dict[[what_br]]

  xaxis_br_dict = list(Data="date", `Dias depois de 10 Casos`="days_gt_10",
                      `Dias depois de 100 Casos`="days_gt_100", `Casos Acumulados`="cases")
  xaxis_br_dict = split(names(xaxis_br_dict), unlist(xaxis_br_dict))
  xaxis_br_label = xaxis_br_dict[[xaxis_br]]

  # Filter dates for each case
  if (what_br == "cases") df_ = coronavirus_br else df_ = coronavirus_br %>% dplyr::filter(date >= "2020-03-16")

  # Plot without or with variation of cases
  if (!delta_br){
    df_ %>%
      ggplot2::ggplot(ggplot2::aes_string(xaxis_br, what_br)) + ggplot2::geom_point() +
        ggplot2::xlab(xaxis_br_label) + ggplot2::ylab(what_br_label) + ggplot2::ylim(0, NA) -> g
  } else {
    df_ %>%
      ggplot2::ggplot(ggplot2::aes_string(xaxis_br, paste0("delta_", what_br))) + ggplot2::geom_point() +
        ggplot2::xlab(xaxis_br_label) + ggplot2::ylab(paste0("Variacao de ", ifelse(what_br=="cases", "Casos", "Mortes"))) + ggplot2::ylim(0, NA) -> g
  }

  if (log_scale_br) g = g + ggplot2::scale_y_log10()
  if (tendency_br) g = g + ggplot2::stat_smooth(method="lm")
  if (xaxis_br == "cases") g = g + ggplot2::scale_x_log10() + ggplot2::xlab(ifelse(xaxis_br=="cases", "Casos Acumulados", "Mortes"))

  g
}

#' plot_coronavirus_states
#'
#'
#' @param coronavirus_br Dataset
#' @param xaxis xaxis variable
#' @param what yaxis variabel
#' @param delta plot variation?
#' @param log_scale plot on log scale?
#' @param tendency plot line tendency?
#' @param filter_state select states to plot
#' @param facet_state facet by state?
#'
#' @export
plot_coronavirus_states = function(coronavirus_br_states, xaxis="date", what="cases",
                             filter_state=c("RJ", "SP"), delta=TRUE, log_scale=TRUE, facet_state=TRUE,
                             tendency=FALSE){
  what_dict = list(Casos="cases", Mortes="deaths")
  what_dict = split(names(what_dict), unlist(what_dict))
  what_label = what_dict[[what]]

  xaxis_dict = list(Data="date", `Dias depois de 10 Casos`="days_gt_10",
                       `Dias depois de 100 Casos`="days_gt_100", `Casos Acumulados`="cases")
  xaxis_dict = split(names(xaxis_dict), unlist(xaxis_dict))
  xaxis_label = xaxis_dict[[xaxis]]


  if (what == "cases") df_ = coronavirus_br_states else df_ = coronavirus_br_states %>% dplyr::filter(date >= "2020-03-16")
  if (!is.null(filter_state)) df_ = dplyr::filter(df_, state %in% filter_state) else df_ = df_

  if (!delta){
    df_ %>%
      dplyr::filter_at(dplyr::vars(dplyr::starts_with(what)), dplyr::any_vars(. > 0)) %>%
      ggplot2::ggplot(ggplot2::aes_string(xaxis, what, color="state")) + ggplot2::geom_point() +
      ggplot2::xlab(xaxis_label) + ggplot2::ylab(what_label) + ggplot2::ylim(0, NA) -> g
  } else {
    df_ %>%
      ggplot2::ggplot(ggplot2::aes_string(xaxis, paste0("delta_", what), color="state")) + ggplot2::geom_point() +
      ggplot2::xlab(xaxis_label) + ggplot2::ylab(paste0("Variacao de ", what_label)) + ggplot2::ylim(1, NA) -> g
  }

  if (log_scale) g = g + ggplot2::scale_y_log10()
  if (facet_state) g = g + ggplot2::facet_wrap(~state)
  if (tendency) g = g + ggplot2::stat_smooth(method="lm")
  if (xaxis == "Casos Acumulados") g = g + ggplot2::scale_x_log10() + ggplot2::xlab(xaxis_label)

  g
}
