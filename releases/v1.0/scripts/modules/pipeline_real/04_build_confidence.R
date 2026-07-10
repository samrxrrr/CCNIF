library(jsonlite)

source("scripts/modules/confidence/01_driver_confidence.R")
source("scripts/modules/confidence/02_confidence_tier.R")
source("scripts/modules/confidence/03_confidence_report.R")

build_driver_confidence <- function(

quality,
normalized_score,
reliability

){

score <- driver_confidence_score(

quality,
normalized_score,
reliability

)

report <- new_confidence_report()

report$Quality <- quality
report$NormalizedScore <- normalized_score
report$Reliability <- reliability

report$DriverConfidence <- score
report$ConfidenceTier <- confidence_tier(score)

report$Interpretation <-
paste("Driver confidence:",report$ConfidenceTier)

report

}
