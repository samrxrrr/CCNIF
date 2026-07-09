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

stats <- evidence$Statistics
diag  <- evidence$Diagnostics

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

CV=diag$CV,

Percentile=evidence$Driver$Percentile,

Skewness=diag$Skewness,

OutlierFraction=diag$OutlierCount/diag$N,

MissingFraction=stats$Missing/stats$N

)

}
