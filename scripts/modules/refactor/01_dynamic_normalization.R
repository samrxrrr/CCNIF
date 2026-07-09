library(jsonlite)

source("scripts/modules/dynamic/01_extract_driver_values.R")
source("scripts/modules/normalization/06_domain_normalization.R")

dynamic_normalization <- function(driver){

x <- extract_driver_values(driver)

normalize_variable(

domain=x$Domain,
variable=x$Variable,
value=x$Observed,
ecdf_file=file.path(
"results",
"evidence",
driver,
"Statistics",
"ECDF",
paste0(
x$Domain,
"_",
x$Variable,
"_ECDF.tsv"
)

)

)

}
