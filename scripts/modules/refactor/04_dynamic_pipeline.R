library(jsonlite)

source("scripts/modules/refactor/01_dynamic_normalization.R")
source("scripts/modules/refactor/02_dynamic_quality.R")
source("scripts/modules/refactor/03_dynamic_confidence.R")

source("scripts/modules/reporting/02_build_report.R")
source("scripts/modules/reporting/03_export_report.R")
source("scripts/modules/reporting/04_driver_manifest.R")
source("scripts/modules/reporting/05_export_manifest.R")
source("scripts/modules/reporting/06_validate_driver_report.R")

run_dynamic_pipeline <- function(driver){

cat("\n=====================================\n")
cat("CCNIF DYNAMIC PIPELINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

n <- dynamic_normalization(driver)
q <- dynamic_quality(driver)
c <- dynamic_confidence(driver)

cat("Normalized Score :",round(n$NormalizedScore,4),"\n")
cat("Quality Score    :",round(q$QualityScore,4),"\n")
cat("Confidence Score :",round(c$DriverConfidence,4),"\n")
cat("Confidence Tier  :",c$ConfidenceTier,"\n\n")

report <- build_driver_report(driver)
export_driver_report(report,driver)

manifest <- build_driver_manifest(driver)
export_driver_manifest(manifest,driver)

validation <- validate_driver_report(driver)

print(validation)

validation

}
