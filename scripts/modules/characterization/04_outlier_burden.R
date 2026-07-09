outlier_class <- function(rate){

if(is.na(rate))
return("Unknown")

if(rate < 0.01)
return("Negligible")

if(rate < 0.05)
return("Low")

if(rate < 0.10)
return("Moderate")

if(rate < 0.20)
return("High")

return("Very High")

}
