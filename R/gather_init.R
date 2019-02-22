#' Reshape budget columns long for Initiatives tab
#'
#' @param df FAST data frame to gather
#'
#' @export
#' @importFrom magrittr %>%


gather_init <- function(df){
  #gather
  df <- df %>%
    tidyr::gather(budget_code, amt,
                  dplyr::starts_with("bilat_"), dplyr::starts_with("init2_"),
                  na.rm  = TRUE) %>%
    dplyr::mutate(amt = as.double(amt)) %>%
    dplyr::filter(amt > 0)

  #combine iniatives into type column
  df <- df %>%
    dplyr::mutate(initiative_type = dplyr::coalesce(initiative1, initiative2)) %>%
    dplyr::select(-c(initiative1, initiative2)) %>%
    dplyr::mutate(budget_code = stringr::str_remove(budget_code, "bilat_|init2_"))


  sources <- c("appliedpipeline", "new_gap", "new_ghp_usaid", "new_ghp_state")

  df <- df %>%
    dplyr::mutate(budget_source_total =
                    dplyr::case_when(budget_code %in% sources ~ amt),
                  amt = ifelse(budget_code %in% sources, NA, amt)) %>%
    dplyr::rename(budget = amt)

  df <- df %>%
    dplyr::mutate(prog_prev = dplyr::case_when(stringr::str_detect(budget_code, "prev") ~ "X"),
                  prog_ct   = dplyr::case_when(stringr::str_detect(budget_code, "ct")   ~ "X"),
                  prog_se   = dplyr::case_when(stringr::str_detect(budget_code, "se")   ~ "X"),
                  prog_asp  = dplyr::case_when(stringr::str_detect(budget_code, "asp")  ~ "X"),
                  prog_hts  = dplyr::case_when(stringr::str_detect(budget_code, "hts")  ~ "X"),
                  budget_code = stringr::str_remove(budget_code, "\\..*$") %>% toupper(.))

  #reorder $ to back
  df <- dplyr::select(df, -budget, -budget_source_total, dplyr::everything())

  return(df)
}
