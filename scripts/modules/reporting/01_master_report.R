library(jsonlite)

new_driver_report <- function(){

list(

Metadata=list(

Version="1.0",
Pipeline="CCNIF",
Created=as.character(Sys.time())

),

Evidence=NULL,

Statistics=NULL,

Diagnostics=NULL,

Characterization=NULL,

Reliability=NULL,

Normalization=NULL,

Quality=NULL,

Confidence=NULL,

Interpretation=NULL,

Manifest=NULL

)

}
