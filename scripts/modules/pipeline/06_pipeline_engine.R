library(jsonlite)

source("scripts/modules/pipeline/01_build_statistics.R")
source("scripts/modules/pipeline/02_build_normalization.R")
source("scripts/modules/pipeline/03_build_quality.R")
source("scripts/modules/pipeline/04_build_confidence.R")

source("scripts/modules/integration/01_load_statistics.R")
source("scripts/modules/integration/02_driver_metrics.R")

source("scripts/modules/reporting/01_master_report.R")
source("scripts/modules/reporting/02_build_report.R")
source("scripts/modules/reporting/03_export_report.R")
source("scripts/modules/reporting/04_driver_manifest.R")
source("scripts/modules/reporting/05_export_manifest.R")
source("scripts/modules/reporting/06_validate_driver_report.R")

run_pipeline <- function(driver){

cat("\n=====================================\n")
cat("CCNIF COMPLETE PIPELINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

if(!build_statistics(driver))
stop("Statistics stage failed.")

if(!build_normalization_pipeline(driver))
stop("Normalization stage failed.")

if(!build_quality_pipeline(driver))
stop("Quality stage failed.")

if(!build_confidence_pipeline(driver))
stop("Confidence stage failed.")

metrics <- extract_driver_metrics(
load_statistics(driver)
)

cat("\n=====================================\n")
cat("PIPELINE METRICS\n")
cat("=====================================\n")

print(metrics)

report <- build_driver_report(driver)
export_driver_report(report,driver)

manifest <- build_driver_manifest(driver)
export_driver_manifest(manifest,driver)

validation <- validate_driver_report(driver)

cat("\n=====================================\n")
cat("PIPELINE SUMMARY\n")
cat("=====================================\n")

print(validation)

validation

}
