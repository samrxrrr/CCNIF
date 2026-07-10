library(jsonlite)

new_normalization_object <- function(){

list(

Metadata=list(

Version="1.0",

Pipeline="CCNIF",

Created=as.character(Sys.time())

),

Input=NULL,

Method=NULL,

Direction=NULL,

Percentile=NULL,

Probability=NULL,

NormalizedScore=NULL,

ScaledScore=NULL,

DomainScore=NULL,

Interpretation=NULL,

Diagnostics=NULL

)

}

