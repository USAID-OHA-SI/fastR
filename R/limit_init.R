#' Reduce to relevant rows and columns in Initiatives Tab
#'
#' @param df FAST data frame to narrow down
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%

limit_init <- function(df, filepath){

  #fix column names (since dups)
  #old version only has 2 initiatves, not 3 like new
  if(is_oldformat(filepath))
    init_headers <- init_headers[!init_headers %in%
                                   c(stringr::str_match(init_headers, "initiative3|init3_.*"))]
  #regional needs country included
  if(is_regional(df))
    init_headers <- append(init_headers, "country", 3)

  #fix for extra column in West Central Africa
  if("0" %in% names(df) && is_regional(df))
    init_headers <- c(init_headers, "extra_drop")

  colnames(df) <- init_headers

  #filter out missing and aggregated rows & drop any withou an intervention total
  df <- df %>%
    dplyr::filter(fundingagency != "TOTALS (to check)",
                  !is.na(fundingagency),
                  intervention_total_drop > 0)

  #drop no essential columns
  df <- df %>%
    dplyr::select(-dplyr::ends_with("_drop"))

  return(df)
}
