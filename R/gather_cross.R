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
    #df <- dplyr::mutate(df, initiative_type = dplyr::coalesce(initiative2, initiative1))
    df <- df %>%
      dplyr::mutate_at(dplyr::vars(initiative1, initiative2), ~ dplyr::na_if(., 0)) %>%
      tidyr::unite(initiative_type, initiative1, initiative2, sep = "/") %>%
      dplyr::mutate(initiative_type = stringr::str_remove_all(initiative_type, "/NA"),
                    initiative_type = stringr::str_remove_all(initiative_type, "Bilateral 19/"))
  } else {
    #df <- dplyr::mutate(df, initiative_type = dplyr::coalesce(initiative3, initiative2, initiative1))
    df <- df %>%
      dplyr::mutate_at(dplyr::vars(initiative1, initiative2, initiative3), ~ dplyr::na_if(., 0)) %>%
      tidyr::unite(initiative_type, initiative1, initiative2, initiative3, sep = "/") %>%
      dplyr::mutate(initiative_type = stringr::str_remove_all(initiative_type, "/NA"),
                    initiative_type = stringr::str_remove_all(initiative_type, "Bilateral 19/"))

  }

  #remove initiative columns and references in budget code
  df <- df %>%
    #dplyr::select(-dplyr::starts_with("initiative")) %>%
    dplyr::mutate(init_type = stringr::str_remove(alloc_type, "bilat_|init2_|init3_"))


  df <- df %>%
    dplyr::mutate(initiative_total_new =
                    dplyr::case_when(alloc_type =="new" ~ amt),
                   amt = ifelse(alloc_type =="new", NA, amt)) %>%
    dplyr::rename(crosscutting_alloc = amt) %>%
    dplyr::mutate(alloc_type = toupper(alloc_type))

  return(df)
}
