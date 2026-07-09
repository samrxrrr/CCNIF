library(jsonlite)

new_quality_report <- function(){

list(

Metadata=list(

Version="1.0",
Pipeline="CCNIF",
Created=as.character(Sys.time())

),

Strength=NULL,
Reliability=NULL,
Consistency=NULL,

QualityScore=NULL,
QualityTier=NULL,

Interpretation=NULL

)

}
