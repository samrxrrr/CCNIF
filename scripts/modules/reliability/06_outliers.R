library(jsonlite)

calculate_outliers <- function(driver){

d <- read_json(
file.path("results","evidence",driver,
"Statistics","Distribution_Report.json"),
simplifyVector=TRUE
)$Diagnostics$AbsLog2FC

fraction <- d$OutlierCount/d$N
score <- (1-fraction)*100

list(
Metric="Outliers",
Driver=driver,
OutlierCount=d$OutlierCount,
OutlierFraction=round(fraction,6),
Score=round(score,4)
)

}
