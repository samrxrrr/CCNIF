driver_confidence_score <- function(

quality,
normalized_score,
reliability

){

0.40*quality+
0.35*normalized_score+
0.25*reliability

}
