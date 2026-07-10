library(jsonlite)

source("scripts/modules/refactor/02_dynamic_quality.R")
source("scripts/modules/quality/07_build_quality.R")
source("scripts/modules/quality/08_export_quality.R")
source("scripts/modules/quality/09_quality_manifest.R")

build_quality_pipeline <- function(driver){

cat("=====================================\n")
cat("QUALITY PIPELINE\n")
cat("=====================================\n")

base <- file.path("results","evidence",driver,"Statistics")

x <- extract_driver_values(driver)

n <- read_json(
file.path(base,"Normalization_Report.json"),
simplifyVector=TRUE
)

r <- read_json(
file.path(base,"Reliability_Report.json"),
simplifyVector=TRUE
)

report <- build_quality(

normalized_score=n$NormalizedScore,

sample_size=x$Rows,

missing_fraction=x$MissingFraction,

outlier_fraction=x$OutlierFraction,

cv=x$CV,

skewness=x$Skewness

)

manifest <- new_quality_manifest()

manifest$QualityReport <-
file.path(base,"Quality_Report.json")

manifest$NormalizationReport <-
file.path(base,"Normalization_Report.json")

manifest$ReliabilityReport <-
file.path(base,"Reliability_Report.json")

manifest$DistributionReport <-
file.path(base,"Distribution_Report.json")

manifest$Evidence <-
file.path(
"results",
"evidence",
driver,
"Evidence",
"Transcriptomics_Evidence.json"
)

export_quality(
report,
manifest,
base
)

cat("Quality exported.\n")

TRUE

}
