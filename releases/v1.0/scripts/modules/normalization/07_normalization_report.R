library(jsonlite)

new_normalization_report <- function(){

list(

Metadata=list(

Version="1.0",
Pipeline="CCNIF",
Created=as.character(Sys.time())

),

Input=NULL,

Direction=NULL,

Percentile=NULL,

Probability=NULL,

NormalizedScore=NULL,

Interpretation=NULL,

Diagnostics=NULL

)

}
