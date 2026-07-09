strength_score <- function(

normalized_score

){

if(is.null(normalized_score))
return(NA)

max(

0,

min(

100,

normalized_score

)

)

}
