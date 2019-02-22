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
#'   df_dp <- run_fastR(path, "Malawi") }

run_fastR <- function(filepath, ou = NULL){

  #read in FAST & munge
  df <- filepath %>%
    import_fast(sheetname = "2 Intervention-E") %>%
    limit_inter() %>%
    sep_cols() %>%
    gather_budget()

  #add OU
  if(!is.null(ou))
    df <- identify_ou(df, ou)

  return(df)

}
