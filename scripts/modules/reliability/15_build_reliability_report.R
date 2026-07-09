library(jsonlite)

safe_load <- function(file){

if(!file.exists(file))
return(NULL)

read_json(

file,

simplifyVector=TRUE

)

}

build_reliability_report <- function(

driver,
domain,
variable

){

report <- new_reliability_report()

report$Metadata$Driver <- driver
report$Metadata$Domain <- domain
report$Metadata$Variable <- variable

report

}
