library(jsonlite)

calculate_sample_size <- function(driver){

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

n <- dist$Statistics$AbsLog2FC$N

list(

Metric="SampleSize",

Driver=driver,

N=n,

Adequate=n>=30,

Score=min(100,n/100*100)

)

}
