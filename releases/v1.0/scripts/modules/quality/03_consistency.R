consistency_score <- function(

cv,

skewness,

outlier_fraction

){

cv_score <- max(

0,

1-cv

)

skew_score <- max(

0,

1-min(abs(skewness)/3,1)

)

outlier_score <- max(

0,

1-outlier_fraction

)

100*(

0.40*cv_score+

0.30*skew_score+

0.30*outlier_score

)

}
