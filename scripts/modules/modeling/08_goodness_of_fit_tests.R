library(nortest)
library(goftest)

goodness_of_fit_tests <- function(x){

x <- x[is.finite(x)]

out <- list(

Metadata=list(

N=length(x)

)

)

if(length(x) < 8){

out$Notes <- "Insufficient sample size"

return(out)

}

## Anderson-Darling

out$AndersonDarling <- tryCatch(

{

t <- ad.test(x)

list(

Statistic=unname(t$statistic),

Pvalue=t$p.value

)

},

error=function(e) NULL

)

## Cramer-von Mises

out$CramerVonMises <- tryCatch(

{

t <- cvm.test(x)

list(

Statistic=unname(t$statistic),

Pvalue=t$p.value

)

},

error=function(e) NULL

)

## Shapiro-Wilk
## (recommended only up to 5000 observations)

out$ShapiroWilk <- tryCatch(

{

if(length(x)<=5000){

t <- shapiro.test(x)

list(

Statistic=unname(t$statistic),

Pvalue=t$p.value

)

}else{

NULL

}

},

error=function(e) NULL

)

## Kolmogorov-Smirnov
## compare against fitted normal

out$KolmogorovSmirnov <- tryCatch(

{

t <- ks.test(

x,

"pnorm",

mean(x),

sd(x)

)

list(

Statistic=unname(t$statistic),

Pvalue=t$p.value

)

},

error=function(e) NULL

)

out

}
