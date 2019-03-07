#' Run FAST Tool consolidation
#'
#' @export

selfservice <- function(){

  r <- menu(c("Yes", "No"), title = "Do you want to run the Fast Tool file consolidation?")

  if(r == 1){

    winDialog(type = "ok",
              "Select the FAST Tool files to consolidate")

    files <- choose.files(caption = "Select FAST Tools to import")

    c_fast <- purrr::map_dfr(.x = files,
                             .f = fastR::combo_fastR)

    answer <- menu(c("Yes", "No"),
                   title = "Do you want to save the Fast Tool file consolidation?")

    if(answer == 1){
      output_path <- choose.dir(caption = "Select folder for saving")

      filename <- paste0("COP19_FAST_Consolidated_", format(Sys.Date(), "%Y%m%d"), ".csv")

      readr::write_csv(c_fast,
                       file.path(output_path,filename),
                       na = "")

      print("Saved to:", output_path)
    } else {
      return(c_fast)
    }
  }


}
