probability_transform <- function(

percentile,

direction

){

if(direction=="HIGHER_BETTER"){

return(percentile)

}

1-percentile

}
