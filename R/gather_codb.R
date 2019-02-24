#' Reshape budget columns long for CODB tab
#'
#' @param df FAST data frame to gather
#'
#' @export
#' @importFrom magrittr %>%


gather_codb <- function(df){

  #gather
  df <- df %>%
    tidyr::gather(budget_code, amt,
                  dplyr::starts_with("bilat_"), dplyr::starts_with("init2_"), dplyr::starts_with("init3_"),
                  na.rm  = TRUE) %>%
    dplyr::mutate(amt = stringr::str_remove(amt, "-"),
                  amt = as.double(amt)) %>%
    dplyr::filter(amt > 0)

  #combine iniatives into type column
    df <- dplyr::mutate(df, initiative_type = dplyr::coalesce(initiative1, initiative2, initiative3))

  #remove initiative columns and references in budget code
  df <- df %>%
    dplyr::select(-dplyr::starts_with("initiative")) %>%
    dplyr::mutate(budget_code = stringr::str_remove(budget_code, "bilat_|init2_|init3_"))


  sources <- c("appliedpipeline", "new_gap", "new_ghp_usaid", "new_ghp_state")

  df <- df %>%
    dplyr::mutate(codb_source_total =
                    dplyr::case_when(budget_code %in% sources ~ amt),
                  amt = ifelse(budget_code %in% sources, NA, amt),
                  budget_code = toupper(budget_code)) %>%
    dplyr::rename(codb = amt)

  return(df)
}
