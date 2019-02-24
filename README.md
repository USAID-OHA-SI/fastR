# fastR

Import COP19 FAST Tool & make tidy/usable

[![Travis build status](https://travis-ci.org/USAID-OHA-SI/fastR.svg?branch=master)](https://travis-ci.org/USAID-OHA-SI/fastR)

## Installation

You can install the released version of `fastR` from GitHub with:


``` r
install.packages("devtools")

devtools::install_github("USAID-OHA-SI/fastR")
```

## Use

The main function of `fastR` is to bring import a COP19 FAST Tool into R and make it tidy.

- Imports FAST Intervention tab into long, tidy format
- Limits data set to just rows with values
- Separates out a Service Delivery and Non-Service Delivery column
- Separates out a sub beneficiary column from beneficiary

The import works for the following tabs in the FAST:

- 2 Intervention-E
- 3 Initiative-E
- 4 Cross-Cutting-E
- 5 Commodities-E
- 6 CODB-P

``` r
#load package
  library(fastR)
  
#FAST file path (.xls) [COP19]
   path <- "../Downloads/FAST Malawi Consolidated Zero Draft 02082019.xlsx"
  
#read in FAST
   df_fast <- run_fastR(path, "2 Intervention-E")
```

You can use one of the `map()` functions from `purrr` package to read in multiple Data Packs and combine.

``` r
#load package
  library(purrr)

#identify all the FAST files
  files <- list.files("../Downloads/FAST_Tools", full.names = TRUE)

#read in all FAST files and combine into one data frame
  df_all <- map_dfr(.x = files,
                    .f = ~ run_fastR(.x, "2 Intervention-E"))
```

---

*Disclaimer: The findings, interpretation, and conclusions expressed herein are those of the authors and do not necessarily reflect the views of United States Agency for International Development. All errors remain our own.*
