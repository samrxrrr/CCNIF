dispersion_metrics <- function(x){

x <- x[is.finite(x)]

list(

MAD=mad(x),

IQR=IQR(x),

Range=diff(range(x))

)

}
