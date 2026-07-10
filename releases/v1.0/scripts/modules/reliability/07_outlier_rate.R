outlier_metrics <- function(x){

x <- x[is.finite(x)]

q1 <- quantile(x,0.25)
q3 <- quantile(x,0.75)
iqr <- IQR(x)

lower <- q1 - 1.5 * iqr
upper <- q3 + 1.5 * iqr

lower_ext <- q1 - 3 * iqr
upper_ext <- q3 + 3 * iqr

outliers <- x < lower | x > upper
extreme  <- x < lower_ext | x > upper_ext

list(

OutlierCount = sum(outliers),

OutlierFraction = sum(outliers)/length(x),

ExtremeCount = sum(extreme),

ExtremeFraction = sum(extreme)/length(x),

LowerFence = lower,

UpperFence = upper,

LowerExtreme = lower_ext,

UpperExtreme = upper_ext

)

}
