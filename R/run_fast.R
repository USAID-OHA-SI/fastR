#' Run the COP19 FAST Importer
#'
#' @param filepath full file path for the COP19 FAST
#' @param ou specify the operatingunit
#'
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' #FAST file path
#'   path <- "../Downloads/FAST Malawi Consolidated Zero Draft 02082019.xlsx"
#' #read in FAST
#'   df_dp <- tame_dp(path, "Malawi") }

run_fast <- function(filepath, ou = NULL){

  #read in FAST
  df <- import_fast(path,
                    sheetname = "2 Intervention-E",
                    skiprows = 2)
  #munge
  df <- df %>%
    limit_fast() %>%
    sep_cols() %>%
    gather_budget()

  #add OU
  if(!is.null(ou))
    df <- identify_ou(df, ou)

  return(df)

}
