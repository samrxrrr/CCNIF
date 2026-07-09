library(jsonlite)

extract_gof <- function(model){

if(is.null(model))
return(NULL)

list(

LogLikelihood=unname(model$loglik),

AIC=AIC(model),

BIC=BIC(model)

)

}

