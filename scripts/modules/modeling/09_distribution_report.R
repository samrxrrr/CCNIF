library(jsonlite)

new_distribution_report <- function(){

list(

Metadata=list(

Version="1.0",

Pipeline="CCNIF",

Created=as.character(Sys.time())

),

Statistics=NULL,

Diagnostics=NULL,

Characterization=NULL,

ECDF=NULL,

Interpolation=NULL,

EmpiricalModel=NULL,

ParametricFits=NULL,

GoodnessOfFit=NULL,

ModelComparison=NULL,

BestModel=NULL,

Interpretation=NULL,

Notes=NULL

)

}
