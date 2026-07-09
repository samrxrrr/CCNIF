power_metrics <- function(x){

x <- x[is.finite(x)]

n <- length(x)

sdx <- sd(x)

se <- sdx/sqrt(n)

moe95 <- 1.96*se

list(

N=n,

DegreesFreedom=max(n-1,0),

EffectiveSampleSize=n,

StandardError=se,

MarginOfError95=moe95,

RelativeSE=ifelse(mean(abs(x))==0,NA,se/mean(abs(x)))

)

}
