.onLoad <- function (libname, pkgname)
{

  packageStartupMessage("\nHi! Type selfservice() when you are ready to begin.\n")

  # make data set names global to avoid CHECK notes
  utils::globalVariables ("amt")
  utils::globalVariables ("amt_type")
  utils::globalVariables ("beneficiary")
  utils::globalVariables ("cop")
  utils::globalVariables ("program")
  utils::globalVariables ("programarea")
  utils::globalVariables ("operatingunit")
  utils::globalVariables ("budget_code")
  utils::globalVariables ("initiative1")
  utils::globalVariables ("initiative2")
  utils::globalVariables ("initiative3")
  utils::globalVariables ("budget")
  utils::globalVariables ("budget_source_total")
  utils::globalVariables ("init_headers")
  utils::globalVariables ("fundingagency")
  utils::globalVariables ("intervention_total_drop")
  utils::globalVariables ("dataquality")
  utils::globalVariables ("listpricereference")
  utils::globalVariables ("procurementmanagement")
  utils::globalVariables ("totalitem")
  utils::globalVariables ("totalitem_budget")
  utils::globalVariables ("unitprice")


  utils::globalVariables (".")

  invisible ()
}
