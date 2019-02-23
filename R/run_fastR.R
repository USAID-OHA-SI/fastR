#' Run the COP19 FAST Importer
#'
#' @param filepath full file path for the COP19 FAST
#' @param sheetname name of sheet to import
#'
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' #FAST file path
#'   path <- "../Downloads/FAST Malawi Consolidated Zero Draft 02082019.xlsx"
#' #read in FAST
#'   df_dp <- run_fastR(path, "2 Intervention-E") }

run_fastR <- function(filepath, sheetname = NULL){

  if(is.null(sheetname))
    stop("Enter sheet name")

  df <- import_fast(filepath, sheetname)

  if(sheetname == "2 Intervention-E"){
    df <- df %>%
      limit_inter() %>%
      gather_inter()
  }

  if(sheetname == "3 Initiative-E"){
    df <- df %>%
      limit_init() %>%
      gather_init()
  }

  df <- df %>%
    identify_ou(filepath) %>%
    sep_cols()

  return(df)

}
