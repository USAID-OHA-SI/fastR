#' Reshape budget columns long
#'
#' @param df FAST data frame to gather
#'
#' @export
#' @importFrom magrittr %>%


gather_inter_cop20 <- function(df){


  #remove TOTAL rows and add back in the values stored from above
  df <- df %>%
    dplyr::filter(programarea != "Total Budgeted COP20 Interventions:")

  # clean up and create period
  df <- df %>%
    dplyr::rename(COP18_er = `er$`,
                  COP19_budget = `budget$`,
                  COP20_budget = `cop20$`)

  #gather budget column
  df <- df %>%
    tidyr::gather(amt_type, amt, COP18_er:COP20_budget, na.rm = TRUE) %>%
    dplyr::mutate(amt = as.double(amt)) %>%
    dplyr::filter(amt > 0)

  #rename mechanismid
  df <- dplyr::rename(df, mech_code = mechid)

  #remove TOTAL rows excpet where interventions are missing
  #df <- handle_missing_inter()

  return(df)
}
