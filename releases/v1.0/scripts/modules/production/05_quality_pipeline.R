library(jsonlite)

source("scripts/modules/dynamic/01_extract_driver_values.R")
source("scripts/modules/quality/07_build_quality.R")

build_quality_pipeline <- function(driver){

cat("=====================================\n")
cat("QUALITY PIPELINE\n")
cat("=====================================\n")

x <- extract_driver_values(driver)

norm <- read_json(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Normalization_Report.json"
),
simplifyVector=TRUE
)

report <- build_quality(

normalized_score = norm$NormalizedScore,

sample_size = x$Rows,

missing_fraction = x$MissingFraction,

outlier_fraction = x$OutlierFraction,

cv = x$CV,

skewness = x$Skewness

)

write_json(

report,

file.path(
"results",
"evidence",
driver,
"Statistics",
"Quality_Report.json"
),

pretty=TRUE,
auto_unbox=TRUE

)

cat("Quality exported.\n")

return(report)

}
