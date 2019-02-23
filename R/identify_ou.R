#' Add Operating Unit into FAST Data Frame
#'
#' @param df FAST data frame
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%


identify_ou <- function(df, filepath){

  #pull OU name from PLL sheet & store
    ou <- readxl::read_excel(filepath,
                             sheet = "1 PLL",
                             range = "G4") %>%
      names()

  #add OU name & reorder to first column
    df <- df %>%
      dplyr::mutate(operatingunit = ou) %>%
      dplyr::select(operatingunit, dplyr::everything())
}
