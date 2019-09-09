#' Reduce to relevant rows and columns in CODB Tab
#'
#' @param df FAST data frame to narrow down
#'
#' @export
#' @importFrom magrittr %>%

limit_codb <- function(df){

  #fix column names (since dups)
  colnames(df) <- codb_headers

  #filter out missing blank and non-planning initiatives
  #df <- dplyr::filter(df, keep_amt_drop == 1)

  #filter out missing blank only
  df <- dplyr::filter_at(df, dplyr::vars(amt, appliedpipeline), dplyr::any_vars(!is.na(.)))

  #drop non essential columns
  df <- df %>%
    dplyr::select(-dplyr::ends_with("_drop"))

  return(df)
}
