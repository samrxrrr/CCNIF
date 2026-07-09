confidence_intervals <- function(x){

x <- x[is.finite(x)]

n <- length(x)

m <- mean(x)

s <- sd(x)

se <- s/sqrt(n)

tcrit <- qt(0.975,n-1)

list(

Mean=list(

Estimate=m,

Lower=m-tcrit*se,

Upper=m+tcrit*se

),

Median=list(

Estimate=median(x)

),

SD=list(

Estimate=s

),

Variance=list(

Estimate=var(x)

)

)

}
