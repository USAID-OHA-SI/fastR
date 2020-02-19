#' Separate Columns
#'
#' @param df data frame to separate columns
#'
#' @export
#' @importFrom magrittr %>%

sep_cols_cop20 <- function(df){

  #create Service delivery variable & clean up program area
  if(var_exists(df, "programarea")) {
    df <- df %>%
      dplyr::select(-dplyr::matches("program$")) %>%
      dplyr::mutate(programarea = stringr::str_replace(programarea, "y-b", "y.b")) %>%
      tidyr::separate(programarea, c("program", "programarea", "servicedelivery"),
                      sep = ": |-", fill = "right") %>%
      dplyr::mutate(programarea = stringr::str_replace(programarea, "y.b", "y-b")) %>%
      dplyr::mutate_at(dplyr::vars(programarea, servicedelivery), ~ stringr::str_squish(.))

  }

  #sub beneficiary
  if(var_exists(df, "beneficiary"))
    df <- tidyr::separate(df, beneficiary, c("beneficiary", "subbeneficiary"), sep = ": ")

  #amt_type
  if(var_exists(df, "amt_type"))
    df <- tidyr::separate(df, amt_type, c("cop", "amt_type"), sep = "_") %>%
      dplyr::mutate(cop = toupper(cop),
                    amt_type = stringr::str_to_sentence(amt_type))

  #clean up 0's to NAs
  if(var_exists(df, "orgtype"))
    df <- dplyr::mutate(df, orgtype = ifelse(orgtype == 0, NA, orgtype))
  if(var_exists(df, "partnertype"))
    df <- dplyr::mutate(df, partnertype = ifelse(partnertype == 0, NA, partnertype))


  return(df)

}

