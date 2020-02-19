#' Import COP19 FAST Tool
#'
#' @param filepath full file path for the COP19 FAST
#' @param sheetname name of the sheet/tab to import
#' @param skiprows how many rows to skip
#'
#' @export

import_fast_cop20 <- function(filepath, sheetname, skiprows = 7){

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
