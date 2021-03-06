% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/run_fastR_cop20.R
\name{run_fastR_cop20}
\alias{run_fastR_cop20}
\title{Run the COP19 FAST Importer}
\usage{
run_fastR_cop20(filepath, sheetname = NULL)
}
\arguments{
\item{filepath}{full file path for the COP19 FAST}

\item{sheetname}{name of sheet to import}
}
\description{
Run the COP19 FAST Importer
}
\examples{
\dontrun{
#FAST file path
  path <- "../Downloads/FAST Malawi Consolidated Zero Draft 02082019.xlsx"
#read in FAST
  df_fast <- run_fastR(path, "2 Intervention-E") }
}
