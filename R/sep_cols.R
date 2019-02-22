#' Separate Columns
#'
#' @param df data frame to separate columns
#'
#' @export
#' @importFrom magrittr %>%

sep_cols <- function(df){

  #create Service delivery variable & clean up program area
  df <- df %>%
    dplyr::mutate(servicedelivery = stringr::str_extract(programarea, "(SD|NSD)"),
                  programarea = stringr::str_remove(programarea, "-(SD|NSD)$"),
                  programarea = stringr::str_remove(programarea, "^.*: "))

  #sub beneficiary
  df <- df %>%
    tidyr::separate(beneficiary, c("beneficiary", "subbeneficiary"), sep = ": ")

  return(df)

}

