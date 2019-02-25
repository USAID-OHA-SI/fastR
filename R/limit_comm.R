#' Reduce to relevant rows/columns and rename in Commodities Tab
#'
#' @param df FAST data frame to narrow down
#'
#' @export
#' @importFrom magrittr %>%

limit_comm <- function(df){

  #limit to just first 15 columns (R is having difficulty with missing col names at end)
    df <- df[1:23]

  #rename to fix ending letters (for excel calc)
    df <- df %>%
      dplyr::rename_all(~ stringr::str_remove(., "_.*$")) %>%
      dplyr::rename(totalitem_budget = totalitem)

  #rename all the unit price items for continuity
    df <- df %>%
      dplyr::rename_at(dplyr::vars(procurementmanagement:dataquality), ~ paste0("unitprice_",.)) %>%
      dplyr::rename(unitprice_base = unitprice)

  #rename mechanismid
    df <- dplyr::rename(df, mechanismid = mechid)

  #limit to where there is a budget
    df <- df %>%
      dplyr::filter(totalitem_budget!="0",
                    !is.na(totalitem_budget))

  #conver to values to double (from character)
    suppressWarnings(
      df <- df %>%
        dplyr::mutate_at(dplyr::vars(listpricereference:totalitem_budget), ~ as.double(.))
  )

  return(df)
}






