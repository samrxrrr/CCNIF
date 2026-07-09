library(jsonlite)

source("scripts/modules/refactor/05_load_unified_evidence.R")
source("scripts/modules/production/03_reliability_pipeline.R")

run_unified_reliability <- function(driver){

cat("=====================================\n")
cat("UNIFIED RELIABILITY ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

load_unified_evidence(driver)

result <- build_reliability_pipeline(driver)

cat("Unified reliability complete.\n")

result

}
