#' Import COP19 FAST Tool
#'
#' @param filepath full file path for the COP19 FAST
#' @param sheetname name of the sheet/tab to import
#' @param skiprows how many rows to skip
#'
#' @export

import_fast <- function(filepath, sheetname, skiprows){

  #error in reading in with missing/repeated col names so supress
  suppressMessages(
    df <-
      readxl::read_excel(filepath,
                         sheet = sheetname,
                         skip = skiprows,
                         col_types = "text",
                         .name_repair = fix_names)
  )

  return(df)

}
