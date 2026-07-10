library(jsonlite)

calculate_dispersion <- function(driver){

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

iqr <- d$IQR
sd  <- d$SD
mad <- d$MAD

score <- max(
0,
100-((sd+iqr+mad)*10)
)

list(

Metric="Dispersion",

Driver=driver,

SD=sd,

IQR=iqr,

MAD=mad,

Score=round(score,4)

)

}
