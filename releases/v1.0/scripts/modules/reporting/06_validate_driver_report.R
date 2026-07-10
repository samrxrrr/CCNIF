library(jsonlite)

validate_driver_report <- function(driver){

base <- file.path(

"results",
"evidence",
driver

)

files <- c(

"Driver_Report.json",

"Driver_Manifest.json",

"Statistics/Normalization_Report.json",

"Statistics/Quality_Report.json",

"Statistics/Confidence_Report.json"

)

ok <- file.exists(

file.path(base,files)

)

list(

Driver=driver,

Passed=sum(ok),

Failed=sum(!ok),

Complete=all(ok),

Files=data.frame(

File=files,

Exists=ok,

stringsAsFactors=FALSE

)

)

}
