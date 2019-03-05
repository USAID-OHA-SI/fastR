#' Reduce to relevant rows and columns in CODB Tab
#'
#' @param df FAST data frame to narrow down
#'
#' @export
#' @importFrom magrittr %>%

limit_codb <- function(df){

  #fix column names (since dups)
  colnames(df) <- codb_headers

  #filter out missing and aggregated rows & drop any without an codb total
  df <- df %>%
    dplyr::filter(!stringr::str_detect(costtype, "COP|Cycle|TOTAL|HHS"),
                  total_codb_drop > 0)

  #drop no essential columns
  df <- df %>%
    dplyr::select(-dplyr::ends_with("_drop"))

  return(df)
}
