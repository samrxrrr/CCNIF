missingness_metrics <- function(x){

list(

Total=length(x),

Missing=sum(is.na(x)),

Fraction=sum(is.na(x))/length(x),

Complete=sum(!is.na(x))

)

}
