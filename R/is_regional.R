#' Check if FAST is a Regional Tool
#'
#' @param df data frame to check
#'
#' @export

is_regional <- function(df) {

  #check if country is a variable, only in regional
    var_exists(df, "country")

}
