tail_class <- function(kurt){

if(is.na(kurt))
return("Unknown")

if(kurt < -1)
return("Very Light Tail")

if(kurt >= -1 && kurt < 1)
return("Normal Tail")

if(kurt >= 1 && kurt < 3)
return("Moderately Heavy Tail")

if(kurt >= 3)
return("Very Heavy Tail")

}
