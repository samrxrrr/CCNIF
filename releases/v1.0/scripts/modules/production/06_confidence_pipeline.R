library(jsonlite)

source("scripts/modules/confidence/04_build_confidence.R")

build_confidence_pipeline <- function(driver){

cat("=====================================\n")
cat("CONFIDENCE PIPELINE\n")
cat("=====================================\n")

q <- read_json(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Quality_Report.json"
),
simplifyVector=TRUE
)

n <- read_json(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Normalization_Report.json"
),
simplifyVector=TRUE
)

r <- read_json(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Reliability_Report.json"
),
simplifyVector=TRUE
)

report <- build_driver_confidence(

quality=q$QualityScore,

normalized_score=n$NormalizedScore,

reliability=r$ReliabilityScore

)

write_json(

report,

file.path(
"results",
"evidence",
driver,
"Statistics",
"Confidence_Report.json"
),

pretty=TRUE,
auto_unbox=TRUE

)

cat("Confidence exported.\n")

report

}
