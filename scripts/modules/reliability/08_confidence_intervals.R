library(jsonlite)

calculate_confidence_intervals <- function(driver){

d <- read_json(
file.path("results","evidence",driver,
"Statistics","Distribution_Report.json"),
simplifyVector=TRUE
)$Diagnostics$AbsLog2FC

list(

Metric="ConfidenceIntervals",

Driver=driver,

Lower=d$OutlierLower,

Upper=d$OutlierUpper,

Score=100

)

}
