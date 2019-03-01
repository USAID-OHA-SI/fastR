#' Reshape budget columns long
#'
#' @param df FAST data frame to gather
#'
#' @export
#' @importFrom magrittr %>%


gather_inter <- function(df){

  #gather budget column
    df <- df %>%
      tidyr::gather(cop, amt, dplyr::starts_with("cop"), na.rm = TRUE) %>%
      dplyr::mutate(amt = as.double(amt)) %>%
      dplyr::filter(amt > 0)

  #rename mechanismid
    df <- dplyr::rename(df, mechanismid = mechid)

  #clean up the descriptor columns
    df <- df %>%
      tidyr::separate(cop, c("cop", "amt_type"), sep = "_") %>%
      dplyr::mutate(cop = toupper(cop),
                    amt_type = stringr::str_to_sentence(amt_type))

  #remove TOTAL rows excpet where interventions are missing
    df <- handle_missing_inter(df)

  return(df)
}
