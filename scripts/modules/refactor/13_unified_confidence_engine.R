library(jsonlite)

source("scripts/modules/refactor/12_unified_quality_engine.R")
source("scripts/modules/production/06_confidence_pipeline.R")

run_unified_confidence <- function(driver){

cat("=====================================\n")
cat("UNIFIED CONFIDENCE ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

run_unified_quality(driver)

result <- build_confidence_pipeline(driver)

cat("Unified confidence complete.\n")

result

}
