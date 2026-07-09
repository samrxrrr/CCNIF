library(jsonlite)

calculate_power <- function(driver){

n <- read_json(
file.path("results","evidence",driver,
"Statistics","Distribution_Report.json"),
simplifyVector=TRUE
)$Statistics$AbsLog2FC$N

power <- min(1,n/1000)

list(

Metric="Power",

Driver=driver,

Power=round(power,4),

Score=round(power*100,4)

)

}
