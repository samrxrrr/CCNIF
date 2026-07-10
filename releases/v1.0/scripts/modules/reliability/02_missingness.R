library(jsonlite)

calculate_missingness <- function(driver){

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

missing_fraction <- dist$Statistics$AbsLog2FC$Missing /
                    dist$Statistics$AbsLog2FC$N

score <- (1-missing_fraction)*100

list(

Metric="Missingness",

Driver=driver,

Missing=dist$Statistics$AbsLog2FC$Missing,

N=dist$Statistics$AbsLog2FC$N,

MissingFraction=missing_fraction,

Score=round(score,4)

)

}
