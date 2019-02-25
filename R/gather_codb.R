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

  #add amt_type for combining
  df <- dplyr::mutate(df, amt_type = "CODB")

  #clean up budget code
  df <- df %>%
    dplyr::mutate(budget_code = toupper(budget_code),
                  budget_code = ifelse(budget_code == "APPLIEDPIPELINE", "Applied Pipeline", budget_code))

  #reorder $ to back
  df <- dplyr::select(df, -amt, dplyr::everything())

  return(df)
}
