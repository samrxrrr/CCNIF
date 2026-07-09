library(jsonlite)

new_confidence_report <- function(){

list(

Metadata=list(

Version="1.0",
Pipeline="CCNIF",
Created=as.character(Sys.time())

),

Quality=NULL,

NormalizedScore=NULL,

Reliability=NULL,

DriverConfidence=NULL,

ConfidenceTier=NULL,

Interpretation=NULL

)

}
