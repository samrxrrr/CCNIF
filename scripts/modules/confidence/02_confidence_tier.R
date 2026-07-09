confidence_tier <- function(score){

if(score>=95)
return("A+")

if(score>=90)
return("A")

if(score>=80)
return("B")

if(score>=70)
return("C")

"D"

}
