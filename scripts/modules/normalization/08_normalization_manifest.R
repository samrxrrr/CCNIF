library(jsonlite)

new_normalization_manifest <- function(){

list(

Metadata=list(

Version="1.0",
Created=as.character(Sys.time())

),

NormalizationReport=NULL,
ECDF=NULL,
Registry=NULL,
Evidence=NULL

)

}
