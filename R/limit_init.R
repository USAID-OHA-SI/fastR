#' Reduce to relevant rows and columns in Initiatives Tab
#'
#' @param df FAST data frame to narrow down
#'
#' @export
#' @importFrom magrittr %>%

limit_init <- function(df){

  #fix column names (since dups)
  colnames(df) <- init_headers

  #filter out missing and aggregated rows & drop any withou an intervention total
  df <- df %>%
    dplyr::filter(fundingagency != "TOTALS (to check)",
                  !is.na(fundingagency),
                  intervention_total_drop > 0)

  #drop no essential columns
  df <- df %>%
    dplyr::select(-dplyr::ends_with("_drop"))

  return(df)
}
