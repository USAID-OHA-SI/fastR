#' Fix column names
#'
#' @param x vector of column names


fix_names <- function(x){
  x %>%
    stringr::str_replace("%", "Percent") %>%
    stringr::str_replace(" (Expenditure|Percent|Budget)", "_\\1") %>%
    stringr::str_remove_all(" ") %>%
    stringr::str_to_lower()
}
