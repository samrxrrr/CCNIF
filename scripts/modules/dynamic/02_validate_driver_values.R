validate_driver_values <- function(x){

required <- c(

"Observed",
"Percentile",
"Rows",
"Mean",
"Median",
"SD",
"MAD",
"CV",
"Skewness",
"OutlierFraction",
"MissingFraction"

)

missing <- c()

for(n in required){

if(is.null(x[[n]]))
missing <- c(missing,n)

}

list(

Complete=length(missing)==0,

Missing=missing,

Present=length(required)-length(missing),

Total=length(required)

)

}
