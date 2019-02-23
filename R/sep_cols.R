#' Separate Columns
#'
#' @param df data frame to separate columns
#'
#' @export
#' @importFrom magrittr %>%

sep_cols <- function(df){

  #create Service delivery variable & clean up program area
  df <- df %>%
    dplyr::mutate(programarea = stringr::str_replace(programarea, "y-b", "y.b")) %>%
    tidyr::separate(programarea, c("programarea", "servicedelivery"), sep = "-", fill = "right") %>%
    dplyr::mutate(programarea = stringr::str_replace(programarea, "y.b", "y-b"),
                  programarea = stringr::str_remove(programarea, "^.*: "))

  #sub beneficiary
  df <- df %>%
    tidyr::separate(beneficiary, c("beneficiary", "subbeneficiary"), sep = ": ")

  return(df)

}

