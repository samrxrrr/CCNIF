reliability_score <- function(

sample_size,

missing_fraction,

outlier_fraction

){

s <- min(sample_size/1000,1)

m <- 1-missing_fraction

o <- 1-outlier_fraction

100*(

0.40*s+

0.35*m+

0.25*o

)

}
