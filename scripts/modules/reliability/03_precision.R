library(jsonlite)

calculate_precision <- function(driver){

dist <- read_json(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Distribution_Report.json"
),
simplifyVector=TRUE
)

cv <- dist$Diagnostics$AbsLog2FC$CV

score <- max(0,100-(cv*20))

list(

Metric="Precision",

Driver=driver,

CV=cv,

Score=round(score,4)

)

}
