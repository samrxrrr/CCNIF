library(jsonlite)

###############################################################################
# EVIDENCE
###############################################################################

source("scripts/modules/evidence/00_extract_driver_record.R")
source("scripts/modules/evidence/01_build_transcriptomics_evidence.R")
source("scripts/modules/evidence/02_build_clinical_evidence.R")
source("scripts/modules/evidence/03_build_functional_evidence.R")
source("scripts/modules/evidence/04_build_network_evidence.R")
source("scripts/modules/evidence/05_build_survival_evidence.R")
source("scripts/modules/evidence/06_build_enrichment_evidence.R")
source("scripts/modules/evidence/07_build_unified_evidence.R")
source("scripts/modules/pipeline/01_build_statistics.R")
source("scripts/modules/production/01_statistics_pipeline.R")
source("scripts/modules/production/02_distribution_pipeline.R")
source("scripts/modules/production/03_reliability_pipeline.R")
source("scripts/modules/production/04_normalization_pipeline.R")
source("scripts/modules/production/05_quality_pipeline.R")
source("scripts/modules/production/06_confidence_pipeline.R")
source("scripts/modules/production/07_reporting_pipeline.R")

###############################################################################
# PRODUCTION
###############################################################################

source("scripts/modules/production/01_statistics_pipeline.R")
source("scripts/modules/production/03_reliability_pipeline.R")
source("scripts/modules/production/04_normalization_pipeline.R")
source("scripts/modules/production/05_quality_pipeline.R")
source("scripts/modules/production/06_confidence_pipeline.R")
source("scripts/modules/reporting/01_master_report.R")
source("scripts/modules/reporting/02_build_report.R")
source("scripts/modules/reporting/03_export_report.R")
source("scripts/modules/reporting/04_driver_manifest.R")
source("scripts/modules/reporting/05_export_manifest.R")
source("scripts/modules/reporting/06_validate_driver_report.R")

build_driver <- function(driver){

cat("\n=====================================\n")
cat("CCNIF MASTER DRIVER PIPELINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

###############################################################################
cat("[01/15] Extract Driver Record\n")
extract_driver_record(driver)

###############################################################################
cat("[02/15] Transcriptomics Evidence\n")
build_transcriptomics_evidence(driver)

###############################################################################
cat("[03/15] Clinical Evidence\n")
tryCatch({
build_clinical_evidence(driver)
}, error=function(e){
cat("Skipping Clinical:",e$message,"\n")
})

###############################################################################
cat("[04/15] Functional Evidence\n")
tryCatch({
build_functional_evidence(driver)
}, error=function(e){
cat("Skipping Functional:",e$message,"\n")
})

###############################################################################
cat("[05/15] Network Evidence\n")
tryCatch({
build_network_evidence(driver)
}, error=function(e){
cat("Skipping Network:",e$message,"\n")
})

###############################################################################
cat("[06/15] Survival Evidence\n")
tryCatch({
build_survival_evidence(driver)
}, error=function(e){
cat("Skipping Survival:",e$message,"\n")
})

###############################################################################
cat("[07/15] Enrichment Evidence\n")
tryCatch({
build_enrichment_evidence(driver)
}, error=function(e){
cat("Skipping Enrichment:",e$message,"\n")
})

###############################################################################
cat("[08/15] Unified Evidence\n")
build_unified_evidence(driver)

###############################################################################
cat("[09/15] Statistics\n")
stopifnot(build_statistics_pipeline(driver))

###############################################################################
cat("[10/15] Reliability\n")
reliability <- build_reliability_pipeline(driver)
stopifnot(!is.null(reliability))

###############################################################################
cat("[11/15] Normalization\n")
normalization <- build_normalization_pipeline(driver)
stopifnot(!is.null(normalization))

###############################################################################
cat("[12/15] Quality\n")
quality <- build_quality_pipeline(driver)
stopifnot(!is.null(quality))

###############################################################################
cat("[13/15] Confidence\n")
confidence <- build_confidence_pipeline(driver)
stopifnot(!is.null(confidence))

###############################################################################
cat("[14/15] Driver Report\n")

report <- build_driver_report(driver)
export_driver_report(report,driver)

###############################################################################
cat("[15/15] Manifest + Validation\n")

manifest <- build_driver_manifest(driver)
export_driver_manifest(manifest,driver)

validation <- validate_driver_report(driver)

print(validation)

validation

}