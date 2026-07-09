library(jsonlite)

new_quality_manifest <- function(){

list(

Metadata=list(

Version="1.0",

Pipeline="CCNIF",

Created=as.character(Sys.time())

),

QualityReport=NULL,

NormalizationReport=NULL,

ReliabilityReport=NULL,

DistributionReport=NULL,

Evidence=NULL

)

}
