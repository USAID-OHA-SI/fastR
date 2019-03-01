#' Handle missing interventions where there is a Total
#'
#' @param df
#'
#' @importFrom magrittr %>%
#' @export

handle_missing_inter <- function(df){

  #filter for where mechanisms only have 1 row -> just TOTAL (> 0)
    df_inter_missing <- df %>%
      dplyr::group_by(mechanismid, cop) %>%
      dplyr::filter(dplyr::n() == 1) %>%
      dplyr::ungroup() %>%
      #specify these rows as not classified
      dplyr::mutate(program = "ND",
                    programarea = "ND: Not Disaggregated",
                    beneficiary = "Not Disaggregated: Not Disaggregated")

  #remove TOTAL rows and add back in the values stored from above
    df <- df %>%
      dplyr::filter(program != "TOTAL") %>%
      dplyr::bind_rows(df_inter_missing)

    return(df)
}

