#' Chec if variable exist
#'
#' @param df data frame to check against
#' @param var quoted variable of intrest
#'
#' @export

var_exists <- function(df, var) {

  var %in% names(df)

}
