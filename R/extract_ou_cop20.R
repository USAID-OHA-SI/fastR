#' Read in OU Name from FAST PPL tab
#'
#' @param filepath full file path for the COP19 FAST
#' @param cell cell to extract OU name from
#'
#' @export
#' @importFrom magrittr %>%

extract_ou_cop20 <- function(filepath, cell){

  ou <- readxl::read_excel(filepath,
                     sheet = "Mechs List-R",
                     range = cell) %>%
    names()

  return(ou)

}
