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
#'   df_fast <- run_fastR(path, "2 Intervention-E") }

run_fastR_cop20 <- function(filepath, sheetname = NULL){

  if(is.null(sheetname))
    stop("Enter sheet name")

  r <- dplyr::case_when(sheetname == "5 Commodities-E" ~ 1,
                        sheetname == "6 CODB-P"        ~ 106,
                        TRUE                           ~ 7)

  df <- import_fast_cop20(filepath, sheetname, r)

  if(sheetname == "2 Intervention-E"){
    df <- df %>%
      limit_inter_cop20() %>%
      gather_inter_cop20()
  }

  if(sheetname == "3 Initiative-E"){
    df <- df %>%
      limit_init(filepath) %>%
      gather_init(filepath)
  }

  if(sheetname == "4 Cross-Cutting-E"){
    df <- df %>%
      limit_cross(filepath) %>%
      gather_cross(filepath)
  }

  if(sheetname == "5 Commodities-E"){
    df <- df %>%
      limit_comm()
  }

  if(sheetname == "6 CODB-P"){
    df <- df %>%
      limit_codb() %>%
      gather_codb()
  }

  df <- df %>%
    sep_cols_cop20()

  return(df)

}
