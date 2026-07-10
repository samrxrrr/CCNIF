shape_class <- function(skew){

if(is.na(skew))
return("Unknown")

if(abs(skew)<0.5)
return("Approximately Symmetric")

if(skew>=0.5 && skew<1)
return("Moderately Right Skewed")

if(skew>=1)
return("Highly Right Skewed")

if(skew<=-0.5 && skew>-1)
return("Moderately Left Skewed")

if(skew<=-1)
return("Highly Left Skewed")

}
