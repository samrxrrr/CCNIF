library(jsonlite)

source("scripts/modules/pipeline/01_build_statistics.R")
source("scripts/modules/pipeline/02_build_normalization.R")
source("scripts/modules/pipeline/03_build_quality.R")
source("scripts/modules/pipeline/04_build_confidence.R")

source("scripts/modules/reporting/01_master_report.R")
source("scripts/modules/reporting/02_build_report.R")
source("scripts/modules/reporting/03_export_report.R")
source("scripts/modules/reporting/04_driver_manifest.R")
source("scripts/modules/reporting/05_export_manifest.R")
source("scripts/modules/reporting/06_validate_driver_report.R")

build_driver <- function(driver){

cat("\n=====================================\n")
cat("CCNIF AUTOMATIC DRIVER BUILDER\n")
cat("=====================================\n")
cat("Driver :",driver,"\n\n")

cat("[1/7] Statistics\n")
if(!isTRUE(build_statistics(driver)))
stop("Statistics stage failed.")

cat("[2/7] Normalization\n")
if(!isTRUE(build_normalization_pipeline(driver)))
stop("Normalization stage failed.")

cat("[3/7] Quality\n")
if(!isTRUE(build_quality_pipeline(driver)))
stop("Quality stage failed.")

cat("[4/7] Confidence\n")
if(!isTRUE(build_confidence_pipeline(driver)))
stop("Confidence stage failed.")

cat("[5/7] Driver Report\n")
report <- build_driver_report(driver)
export_driver_report(report,driver)

cat("[6/7] Driver Manifest\n")
manifest <- build_driver_manifest(driver)
export_driver_manifest(manifest,driver)

cat("[7/7] Validation\n")
validation <- validate_driver_report(driver)

print(validation)

if(!validation$Complete)
stop("Driver package validation failed.")

cat("\n=====================================\n")
cat("DRIVER PACKAGE COMPLETE\n")
cat("=====================================\n")

return(validation)

}
