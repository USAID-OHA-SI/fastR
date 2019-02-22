#' Run the COP19 FAST Importer
#'
#' @param filepath full file path for the COP19 FAST
#' @param sheetname name of sheet to import
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
#'   df_dp <- run_fastR(path, "2 Intervention-E", "Malawi") }

run_fastR <- function(filepath, sheetname = NULL, ou = NULL){

  if(is.null(sheetname))
    stop("Enter sheet name")

  if(sheetname == "2 Intervention-E"){
    #read in FAST & munge
    df <- filepath %>%
      import_fast("2 Intervention-E") %>%
      limit_inter() %>%
      sep_cols() %>%
      gather_inter()
  }

  if(sheetname == "3 Initiative-E"){
    df <- filepath %>%
      import_fast("3 Initiative-E") %>%
      limit_init() %>%
      sep_cols() %>%
      gather_init()
  }

  #add OU
  if(!is.null(ou))
    df <- identify_ou(df, ou)

  return(df)

}
