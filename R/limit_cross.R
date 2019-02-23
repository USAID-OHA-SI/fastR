#' Reduce to relevant rows and columns in Cross Cutting Tab
#'
#' @param df FAST data frame to narrow down
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%

limit_cross <- function(df, filepath){

  #fix column names (since dups)
  #old version only has 2 initiatves, not 3 like new
  if(is_oldformat(filepath))
    cross_headers <- cross_headers[!cross_headers %in%
                                   c(stringr::str_match(cross_headers, "initiative3|init3_.*"))]

  colnames(df) <- cross_headers

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
