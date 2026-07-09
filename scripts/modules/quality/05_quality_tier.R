quality_tier <- function(score){

if(score>=90)
return("Platinum")

if(score>=80)
return("Gold")

if(score>=70)
return("Silver")

if(score>=60)
return("Bronze")

"Weak"

}
