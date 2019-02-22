.onLoad <- function (libname, pkgname)
{
  # make data set names global to avoid CHECK notes
  utils::globalVariables ("amt")
  utils::globalVariables ("amt_type")
  utils::globalVariables ("beneficiary")
  utils::globalVariables ("cop")
  utils::globalVariables ("path")
  utils::globalVariables ("program")
  utils::globalVariables ("programarea")
  utils::globalVariables ("operatingunit")

  invisible ()
}
