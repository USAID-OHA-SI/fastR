#' Reshape budget columns long
#'
#' @param df FAST data frame to gather
#'
#' @export
#' @importFrom magrittr %>%


gather_budget <- function(df){

  #gather budget column
    df <- df %>%
      tidyr::gather(cop, amt, dplyr::starts_with("cop"), na.rm = TRUE)

  #clean up the descriptor columns
    df <- df %>%
      tidyr::separate(cop, c("cop", "amt_type"), sep = "_") %>%
      dplyr::mutate(cop = toupper(cop),
                    amt_type = stringr::str_to_sentence(amt_type))

  return(df)
}
