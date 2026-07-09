library(jsonlite)

calculate_stability <- function(driver){

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

d <- dist$Diagnostics$AbsLog2FC

cv <- d$CV
skew <- abs(d$Skewness)

score <- max(
0,
100-(cv*15+skew*5)
)

list(

Metric="Stability",

Driver=driver,

CV=cv,

Skewness=skew,

Score=round(score,4)

)

}
