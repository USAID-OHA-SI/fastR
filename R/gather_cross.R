#' Reshape budget columns long for Cross Cutting tab
#'
#' @param df FAST data frame to gather
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%


gather_cross <- function(df, filepath){
  #gather
  df <- df %>%
    tidyr::gather(alloc_type, amt,
                  dplyr::starts_with("bilat_"), dplyr::starts_with("init2_"), dplyr::starts_with("init3_"),
                  na.rm  = TRUE) %>%
    dplyr::mutate(amt = stringr::str_remove(amt, "-"),
                  amt = as.double(amt)) %>%
    dplyr::filter(amt > 0)

  #combine iniatives into type column
  if(is_oldformat(filepath)) {
    df <- dplyr::mutate(df, initiative_type = dplyr::coalesce(initiative1, initiative2))
  } else {
    df <- dplyr::mutate(df, initiative_type = dplyr::coalesce(initiative1, initiative2, initiative3))
  }

  #remove initiative columns and references in budget code
  df <- df %>%
    dplyr::select(-dplyr::starts_with("initiative")) %>%
    dplyr::mutate(init_type = stringr::str_remove(alloc_type, "bilat_|init2_|init3_"))


  df <- df %>%
    dplyr::mutate(initiative_total_new =
                    dplyr::case_when(alloc_type =="new" ~ amt),
                   amt = ifelse(alloc_type =="new", NA, amt)) %>%
    dplyr::rename(crosscutting_alloc = amt) %>%
    dplyr::mutate(alloc_type = toupper(alloc_type))

  return(df)
}
