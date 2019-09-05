#' Reshape budget columns long for CODB tab
#'
#' @param df FAST data frame to gather
#'
#' @export
#' @importFrom magrittr %>%


gather_codb <- function(df){

  #move pipeline to amount
    df <- df %>%
      dplyr::mutate(budget_code = ifelse(!is.na(appliedpipeline), "Applied Pipeline", budget_code),
                    amt = ifelse(!is.na(appliedpipeline), appliedpipeline, amt) %>% as.numeric) %>%
      dplyr::select(-appliedpipeline)

  #add variables for combining
    df <- dplyr::mutate(df, amt_type = "CODB")

  #remove spacing
    df <- dplyr::mutate(df, cop = stringr::str_remove(cop, " "))

  #reorder $ to back
    df <- dplyr::select(df, -amt, dplyr::everything())

  return(df)
}
