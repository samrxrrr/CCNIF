dispersion_class <- function(cv){

if(is.na(cv))
return("Unknown")

if(cv < 0.10)
return("Very Low")

if(cv < 0.25)
return("Low")

if(cv < 0.50)
return("Moderate")

if(cv < 1.00)
return("High")

return("Very High")

}
