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
                    programarea = ifelse(programarea == "Laboratory systems strengthening", "Laboratory Systems Stregthening", programarea),
                    servicedelivery = ifelse(is.na(servicedelivery),  program, servicedelivery)) %>%
      dplyr::mutate_at(dplyr::vars(programarea, servicedelivery), ~ stringr::str_squish(.))

  }

  #sub beneficiary
  if(var_exists(df, "beneficiary"))
    df <- tidyr::separate(df, beneficiary, c("beneficiary", "subbeneficiary"), sep = ": ")

  #clean up 0's to NAs
  if(var_exists(df, "orgtype"))
    df <- dplyr::mutate(df, orgtype = ifelse(orgtype == 0, NA, orgtype))
  if(var_exists(df, "partnertype"))
    df <- dplyr::mutate(df, partnertype = ifelse(partnertype == 0, NA, partnertype))


  return(df)

}

