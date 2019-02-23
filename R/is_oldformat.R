#' Check if the FAST is the old, preSGAC validated version
#'
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%

is_oldformat <- function(filepath){

  #old formats have ou name in E4, not G4
  extract_ou(filepath, "G4") %>%
    length() == 0

}
