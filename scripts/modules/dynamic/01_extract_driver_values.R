library(jsonlite)

extract_driver_values <- function(driver){

evidence <- read_json(
file.path(
"results",
"evidence",
driver,
"Evidence",
"Transcriptomics_Evidence.json"
),
simplifyVector=TRUE
)

distribution <- read_json(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Distribution_Report.json"
),
simplifyVector=TRUE
)

stats <- distribution$Statistics$AbsLog2FC

list(

Driver=driver,

Observed=evidence$Raw$Observed,

Domain=evidence$Metadata$Domain,

Variable=evidence$Metadata$Variable,

Rows=stats$N,

Mean=stats$Mean,

Median=stats$Median,

SD=stats$SD,

MAD=stats$MAD,

CV=stats$SD/stats$Mean,

Percentile=evidence$Distribution$Percentile,

Skewness=distribution$Diagnostics$AbsLog2FC$Skewness,

OutlierFraction=distribution$Diagnostics$AbsLog2FC$OutlierFraction,

MissingFraction=stats$Missing/stats$N

)

}
