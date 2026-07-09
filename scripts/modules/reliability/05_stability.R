stability_metrics <- function(x){

x <- x[is.finite(x)]

list(

Mean=mean(x),

Median=median(x),

CV=sd(x)/abs(mean(x))

)

}
