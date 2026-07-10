library(jsonlite)

source("scripts/modules/dynamic/01_extract_driver_values.R")
source("scripts/modules/quality/07_build_quality.R")

dynamic_quality <- function(driver){

x <- extract_driver_values(driver)

build_quality(

normalized_score=x$Percentile*100,
sample_size=x$Rows,
missing_fraction=x$MissingFraction,
outlier_fraction=x$OutlierFraction,
cv=x$CV,
skewness=x$Skewness

)

}
