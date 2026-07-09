library(jsonlite)

extract_driver_values <- function(driver){

base <- file.path(
"results",
"evidence",
driver
)

evidence <- read_json(
file.path(
base,
"Evidence",
"Transcriptomics_Evidence.json"
),
simplifyVector=TRUE
)

dist <- read_json(
file.path(
base,
"Statistics",
"Distribution_Report.json"
),
simplifyVector=TRUE
)

stats <- dist$Statistics$AbsLog2FC
diag  <- dist$Diagnostics$AbsLog2FC

list(

Driver=driver,

Observed=evidence$Raw$Observed,

Domain=evidence$Metadata$Domain,

Variable="AbsLog2FC",

Rows=as.numeric(stats$N),

Mean=as.numeric(ifelse(is.null(stats$Mean),0,stats$Mean)),

Median=as.numeric(ifelse(is.null(stats$Median),0,stats$Median)),

SD=as.numeric(diag$SD),

MAD=as.numeric(diag$MAD),

CV=as.numeric(diag$CV),

Percentile=as.numeric(evidence$Driver$Percentile),

Skewness=as.numeric(diag$Skewness),

OutlierFraction=as.numeric(diag$OutlierCount)/as.numeric(diag$N),

MissingFraction=as.numeric(stats$Missing)/as.numeric(stats$N)

)

}
