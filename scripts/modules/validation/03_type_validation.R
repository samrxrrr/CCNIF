library(jsonlite)

source("scripts/modules/validation/00_variable_registry.R")

validate_variable <- function(variable,values){

info <- get_variable_info(variable)

if(is.null(info)){

return(list(

Variable=variable,

Known=FALSE,

Status="Unknown"

))

}

type <- info$Type

out <- list(

Variable=variable,

Known=TRUE,

Type=type,

Checks=list()

)

if(type=="identifier"){

out$Checks$Numeric <- FALSE
out$Checks$SkipStatistics <- TRUE

}

if(type=="ordinal"){

out$Checks$Ordered <- TRUE

}

if(type=="probability"){

out$Checks$LowerBound <- min(values)>=0
out$Checks$UpperBound <- max(values)<=1

}

if(type=="positive"){

out$Checks$PositiveOnly <- min(values)>0

}

if(type=="count"){

out$Checks$Integer <- all(values%%1==0)

}

if(type=="continuous"){

out$Checks$Finite <- all(is.finite(values))

}

if(type=="percentile"){

out$Checks$LowerBound <- min(values)>=0
out$Checks$UpperBound <- max(values)<=1

}

out

}
