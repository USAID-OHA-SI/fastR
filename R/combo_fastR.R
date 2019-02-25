#' Combine sheets from FAST - Intervention, Initiative, CODB
#'
#' @param filepath full file path for the COP19 FAST
#'
#' @export
#' @importFrom magrittr %>%
#'
#' @examples
#' \dontrun{
#' #FAST file path
#'   path <- "../Downloads/FAST Malawi Consolidated Zero Draft 02082019.xlsx"
#' #read in FAST
#'   df_fast <- combo_fastR(path) }

combo_fastR <- function(filepath){

  #create dfs from tab to combine
  df_inter <- run_fastR(filepath, "2 Intervention-E")
  df_init <- run_fastR(filepath, "3 Initiative-E")
  df_codb <- run_fastR(filepath, "6 CODB-P")

  #get types from interventions tab
  distinct_types <- dplyr::distinct(df_inter, mechanismid, partnertype, orgtype)

  #add types to iniatives
  df_init_full <- df_init %>%
    dplyr::mutate(cop = "COP19",
                  amt_type = "Budget") %>%
    dplyr::left_join(distinct_types, by = "mechanismid") %>%
    dplyr::select(-amt, dplyr::everything())

  #combine interventions and iniatives
  df_combo <- df_inter %>%
    dplyr::filter(cop != "COP19") %>%
    dplyr::bind_rows(df_init_full) %>%
    dplyr::select(-amt, dplyr::everything())

  #add COP year to CODB
  df_codb_adj <- df_codb %>%
    dplyr::mutate(cop = "COP19")

  #combine CODB to others
  df_combo <- df_combo %>%
    dplyr::bind_rows(df_codb_adj) %>%
    dplyr::select(-amt, dplyr::everything())

  return(df_combo)

}

