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
"Skewness"

)

missing <- required[
!required %in% names(x)
]

list(

Complete=length(missing)==0,

Missing=missing,

Fields=length(names(x))

)

}
