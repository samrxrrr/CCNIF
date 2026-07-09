scale_score <- function(

probability,

minimum=0,

maximum=100

){

minimum+(maximum-minimum)*probability

}
