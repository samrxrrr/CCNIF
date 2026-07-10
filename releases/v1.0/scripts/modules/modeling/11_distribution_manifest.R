library(jsonlite)

new_distribution_manifest <- function(){

list(

Metadata=list(

Version="1.0",

Created=as.character(Sys.time())

),

StatisticsModel=NULL,

Diagnostics=NULL,

Characterization=NULL,

ECDF=NULL,

Interpolation=NULL,

EmpiricalModel=NULL,

ParametricFits=NULL,

GoodnessOfFit=NULL,

ModelComparison=NULL,

DistributionReport=NULL

)

}
