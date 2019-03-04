#' Reduce to relevant rows and columns in Intervention Tab
#'
#' @param df FAST data frame to narrow down
#'
#' @export
#' @importFrom magrittr %>%


limit_inter <- function(df){

  #limit to just first 15/16 columns (R is having difficulty with missing col names at end)
    last_col <- match("cop19_budget", colnames(df))
    df[1:last_col]

  #remove rows without day data
  df <- df %>%
    dplyr::filter(!is.na(program))

  #remove percent columns
  df <- df %>%
    dplyr::select(-dplyr::ends_with("percent"))

  return(df)
}
