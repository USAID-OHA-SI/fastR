#' Separate Columns
#'
#' @param df data frame to separate columns
#'
#' @export
#' @importFrom magrittr %>%

sep_cols <- function(df){

  #create Service delivery variable & clean up program area
  if(var_exists(df, "programarea")) {
    df <- df %>%
      dplyr::mutate(programarea = stringr::str_replace(programarea, "y-b", "y.b")) %>%
      tidyr::separate(programarea, c("programarea", "servicedelivery"), sep = "-", fill = "right") %>%
      dplyr::mutate(programarea = stringr::str_replace(programarea, "y.b", "y-b"),
                    programarea = stringr::str_remove(programarea, "^.*: "))

  }

  #sub beneficiary
  if(var_exists(df, "beneficiary"))
    df <- tidyr::separate(df, beneficiary, c("beneficiary", "subbeneficiary"), sep = ": ")


  return(df)

}

