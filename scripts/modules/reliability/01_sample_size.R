sample_size_metrics <- function(x){

x <- x[is.finite(x)]

list(

N=length(x),

Sufficient=length(x)>=30,

LargeSample=length(x)>=100

)

}
