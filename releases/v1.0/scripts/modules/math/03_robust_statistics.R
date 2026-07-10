library(jsonlite)

robust_statistics <- function(object){

x <- object$Raw$Observed

d <- object$Statistics

if(
is.null(d$Median) ||
is.null(d$MAD)
){

return(object)

}

robust_z <- if(d$MAD==0){

NA

}else{

0.6745*(x-d$Median)/d$MAD

}

object$Statistics$RobustZ <- robust_z

object

}
