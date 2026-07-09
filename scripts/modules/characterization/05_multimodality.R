library(diptest)

multimodality_test <- function(x){

x <- x[is.finite(x)]

d <- dip.test(x)

list(

DipStatistic=unname(d$statistic),

Pvalue=unname(d$p.value),

Distribution=ifelse(
d$p.value<0.05,
"Multimodal",
"Unimodal"
)

)

}
