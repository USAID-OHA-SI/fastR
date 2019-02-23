#' Add Operating Unit into FAST Data Frame
#'
#' @param df FAST data frame
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%


identify_ou <- function(df, filepath){

  #pull OU name from PLL sheet & store
  #ref cell changed with SGAC review to G4
  #if not, check in E4
    cell_loc <- ifelse(is_oldformat(filepath), "E4", "G4")
    ou <- extract_ou(filepath, cell_loc)

  #add OU name & reorder to first column
    df <- df %>%
      dplyr::mutate(operatingunit = ou) %>%
      dplyr::select(operatingunit, dplyr::everything())
}
