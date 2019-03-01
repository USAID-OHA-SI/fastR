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
      dplyr::select(-dplyr::matches("program$")) %>%
      dplyr::mutate(programarea = stringr::str_replace(programarea, "y-b", "y.b"),
                    programarea = dplyr::case_when(programarea == "Program management" ~ "PM: Program management",
                                                   programarea == "Non-Targeted Pop: Not disaggregated" ~ "ND: Not Disaggregated",
                                                   TRUE ~ programarea)) %>%
      tidyr::separate(programarea, c("program", "programarea", "servicedelivery"),
                      sep = ": |-", fill = "right") %>%
      dplyr::mutate(programarea = stringr::str_replace(programarea, "y.b", "y-b"),
                    programarea = stringr::str_remove(programarea, "^.*: "),
                    servicedelivery = ifelse(is.na(servicedelivery),  program, servicedelivery))

  }

  #sub beneficiary
  if(var_exists(df, "beneficiary"))
    df <- tidyr::separate(df, beneficiary, c("beneficiary", "subbeneficiary"), sep = ": ")


  return(df)

}

