influence_metrics <- function(x){

x <- x[is.finite(x)]

z <- scale(x)

list(

MaximumAbsoluteZ=max(abs(z)),

MeanAbsoluteZ=mean(abs(z)),

GreaterThan3SD=sum(abs(z)>3),

FractionGreaterThan3SD=sum(abs(z)>3)/length(z)

)

}
