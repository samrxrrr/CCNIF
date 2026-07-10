library(jsonlite)

source("scripts/modules/refactor/03_dynamic_confidence.R")
source("scripts/modules/confidence/04_build_confidence.R")
source("scripts/modules/confidence/05_export_confidence.R")
source("scripts/modules/confidence/06_confidence_manifest.R")

build_confidence_pipeline <- function(driver){

cat("=====================================\n")
cat("CONFIDENCE PIPELINE\n")
cat("=====================================\n")

base <- file.path("results","evidence",driver,"Statistics")

q <- read_json(
file.path(base,"Quality_Report.json"),
simplifyVector=TRUE
)

n <- read_json(
file.path(base,"Normalization_Report.json"),
simplifyVector=TRUE
)

r <- read_json(
file.path(base,"Reliability_Report.json"),
simplifyVector=TRUE
)

report <- build_driver_confidence(

quality=q$QualityScore,

normalized_score=n$NormalizedScore,

reliability=r$ReliabilityScore

)

manifest <- new_confidence_manifest()

manifest$ConfidenceReport <-
file.path(base,"Confidence_Report.json")

manifest$QualityReport <-
file.path(base,"Quality_Report.json")

manifest$NormalizationReport <-
file.path(base,"Normalization_Report.json")

manifest$ReliabilityReport <-
file.path(base,"Reliability_Report.json")

manifest$Evidence <-
file.path(
"results",
"evidence",
driver,
"Evidence",
"Transcriptomics_Evidence.json"
)

export_confidence(
report,
manifest,
base
)

cat("Confidence exported.\n")

TRUE

}
