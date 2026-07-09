library(jsonlite)

compare_models <- function(fits){

models <- c("Normal","LogNormal","Gamma","Weibull")

tbl <- data.frame()

for(m in models){

fit <- fits[[m]]

if(is.null(fit))
next

tbl <- rbind(

tbl,

data.frame(

Distribution=m,

LogLikelihood=fit$loglik,

AIC=AIC(fit),

BIC=BIC(fit),

Parameters=length(fit$estimate),

Converged=TRUE,

stringsAsFactors=FALSE

)

)

}

tbl$AIC_Rank <- rank(tbl$AIC,ties.method="first")

tbl$BIC_Rank <- rank(tbl$BIC,ties.method="first")

best <- tbl$Distribution[which.min(tbl$AIC)]

list(

Summary=tbl,

BestModel=best

)

}
