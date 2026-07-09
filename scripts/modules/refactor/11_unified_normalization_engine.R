library(jsonlite)

source("scripts/modules/refactor/10_unified_reliability_engine.R")
source("scripts/modules/production/04_normalization_pipeline.R")

run_unified_normalization <- function(driver){

cat("=====================================\n")
cat("UNIFIED NORMALIZATION ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

run_unified_reliability(driver)

result <- build_normalization_pipeline(driver)

cat("Unified normalization complete.\n")

result

}
