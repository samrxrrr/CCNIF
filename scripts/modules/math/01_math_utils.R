library(e1071)

safe_mean <- function(x){

x <- x[is.finite(x)]

mean(x)

}

safe_sd <- function(x){

x <- x[is.finite(x)]

sd(x)

}

safe_var <- function(x){

x <- x[is.finite(x)]

var(x)

}

safe_median <- function(x){

x <- x[is.finite(x)]

median(x)

}

safe_iqr <- function(x){

x <- x[is.finite(x)]

IQR(x)

}

safe_mad <- function(x){

x <- x[is.finite(x)]

mad(x)

}

safe_skewness <- function(x){

x <- x[is.finite(x)]

if(length(unique(x))<3) return(NA)

e1071::skewness(x,type=2)

}

safe_kurtosis <- function(x){

x <- x[is.finite(x)]

if(length(unique(x))<4) return(NA)

e1071::kurtosis(x,type=2)

}

safe_cv <- function(x){

x <- x[is.finite(x)]

sd(x)/mean(x)

}

tukey_limits <- function(x){

x <- x[is.finite(x)]

q1 <- quantile(x,.25)

q3 <- quantile(x,.75)

iqr <- IQR(x)

list(

Lower=q1-1.5*iqr,

Upper=q3+1.5*iqr

)

}

outlier_count <- function(x){

x <- x[is.finite(x)]

lim <- tukey_limits(x)

sum(

x<lim$Lower |

x>lim$Upper

)

}
