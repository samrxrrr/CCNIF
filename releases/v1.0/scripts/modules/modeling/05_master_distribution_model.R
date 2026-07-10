library(jsonlite)

new_distribution_model <- function(){

list(

Metadata=list(

Version="1.0",

Created=as.character(Sys.time())

),

Statistics=NULL,

Diagnostics=NULL,

ECDF=NULL,

Empirical=NULL,

ParametricFits=NULL,

GoodnessOfFit=NULL

)

}
