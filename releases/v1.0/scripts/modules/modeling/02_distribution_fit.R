library(fitdistrplus)
library(jsonlite)

fit_candidate_distributions <- function(x){

x <- x[is.finite(x)]

out <- list()

if(length(x)<20)
return(out)

xmin <- min(x)

if(xmin<=0){

shift <- abs(xmin)+1e-8

xpos <- x+shift

}else{

shift <- 0

xpos <- x

}

safe_fit <- function(expr){

tryCatch(expr,error=function(e)NULL)

}

out$Metadata <- list(

N=length(x),

Shift=shift

)

out$Normal <-
safe_fit(fitdist(x,"norm"))

out$LogNormal <-
safe_fit(fitdist(xpos,"lnorm"))

out$Gamma <-
safe_fit(fitdist(xpos,"gamma"))

out$Weibull <-
safe_fit(fitdist(xpos,"weibull"))

out

}
