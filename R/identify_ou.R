#' Add Operating Unit into FAST Data Frame
#'
#' @param df FAST data frame
#' @param ou operatingunit
#'
#' @export
#' @importFrom magrittr %>%


identify_ou <- function(df, ou){
  df <- df %>%
    dplyr::mutate(operatingunit = ou) %>%
    dplyr::select(operatingunit, dplyr::everything())
}
