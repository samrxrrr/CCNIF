precision_metrics <- function(x){

x <- x[is.finite(x)]

list(

Variance=var(x),

SD=sd(x),

SE=sd(x)/sqrt(length(x))

)

}
