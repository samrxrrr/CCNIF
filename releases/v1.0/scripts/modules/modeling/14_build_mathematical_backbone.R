library(jsonlite)

safe_load <- function(file){

if(!file.exists(file))
return(NULL)

read_json(file,simplifyVector=TRUE)

}

build_mathematical_backbone <- function(driver){

base <- file.path("results","evidence",driver,"Statistics")

list(

Metadata=list(

Driver=driver,

Version="1.0",

Created=as.character(Sys.time())

),

DistributionReport=

safe_load(

file.path(

base,

"Distribution_Report.json"

)

),

ReliabilityReport=

safe_load(

file.path(

base,

"Reliability_Report.json"

)

),

Manifest=NULL,

ReadyForNormalization=FALSE

)

}
