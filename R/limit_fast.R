#' Reduce to relevant rows and columns
#'
#' @param df FAST data frame to narrow down
#'
#' @export
#' @importFrom magrittr %>%


limit_fast <- function(df){
  #limit to just first 15 columns (R is having difficulty with missing col names at end)
  df <- df[1:15]

  #remove total rows and rows without day data
  df <- df %>%
    dplyr::filter(program != "TOTAL",
                  !is.na(program))

  #remove percent columns
  df <- df %>%
    dplyr::select(-dplyr::ends_with("percent"))

  return(df)
}
