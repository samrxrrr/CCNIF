library(jsonlite)

calculate_influence <- function(driver){

d <- read_json(
file.path("results","evidence",driver,
"Statistics","Distribution_Report.json"),
simplifyVector=TRUE
)$Diagnostics$AbsLog2FC

score <- max(0,100-(d$OutlierCount/d$N)*100)

list(

Metric="Influence",

Driver=driver,

InfluentialFraction=round(d$OutlierCount/d$N,6),

Score=round(score,4)

)

}
