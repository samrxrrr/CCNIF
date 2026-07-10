library(jsonlite)

source("scripts/modules/normalization/06_domain_normalization.R")
source("scripts/modules/normalization/07_normalization_report.R")

build_normalization <- function(

driver,
domain,
variable,
value,
ecdf_file

){

n <- normalize_variable(

domain=domain,
variable=variable,
value=value,
ecdf_file=ecdf_file

)

r <- new_normalization_report()

r$Metadata$Driver <- driver

r$Input <- list(

Observed=value,
Variable=variable,
Domain=domain

)

r$Direction <- n$Direction
r$Percentile <- n$Percentile
r$Probability <- n$Probability
r$NormalizedScore <- n$NormalizedScore

if(n$NormalizedScore>=90){

r$Interpretation <- "Very High"

}else if(n$NormalizedScore>=75){

r$Interpretation <- "High"

}else if(n$NormalizedScore>=50){

r$Interpretation <- "Moderate"

}else if(n$NormalizedScore>=25){

r$Interpretation <- "Low"

}else{

r$Interpretation <- "Very Low"

}

r

}
