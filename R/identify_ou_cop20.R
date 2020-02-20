#' Add Operating Unit into FAST Data Frame
#'
#' @param df FAST data frame
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%


identify_ou_cop20 <- function(df, filepath){

  #pull OU name from PLL sheet & store
  #ref cell changed with SGAC review to G4
  #if not, check in E4
    cell_loc <- "A2"
    ou <- extract_ou_cop20(filepath, cell_loc)

  #add OU name
    df <- dplyr::mutate(df, operatingunit = ou)

  #add country column if it does not exist
    if(!is_regional(df))
      df <- dplyr::mutate(df, country = ou)

  #reorder w/ OU and country first
   df <-  dplyr::select(df, operatingunit, country, dplyr::everything())

   return(df)
}
