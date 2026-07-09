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

list(

Driver=driver,

Observed=
evidence$Raw$Observed,

Domain=
evidence$Metadata$Domain,

Variable=
evidence$Metadata$Variable,

Percentile=
distribution$Distribution$Percentile,

Rows=
distribution$Statistics$Rows,

Mean=
distribution$Statistics$Mean,

Median=
distribution$Statistics$Median,

SD=
distribution$Statistics$SD,

MAD=
distribution$Statistics$MAD,

CV=
distribution$Statistics$CV,

Skewness=
distribution$Statistics$Skewness,

OutlierFraction=
distribution$Outliers$Fraction,

MissingFraction=
distribution$Missingness$Fraction

)

}
