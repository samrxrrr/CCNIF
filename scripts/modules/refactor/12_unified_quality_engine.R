library(jsonlite)

source("scripts/modules/refactor/11_unified_normalization_engine.R")
source("scripts/modules/production/05_quality_pipeline.R")

run_unified_quality <- function(driver){

cat("=====================================\n")
cat("UNIFIED QUALITY ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

run_unified_normalization(driver)

result <- build_quality_pipeline(driver)

cat("Unified quality complete.\n")

result

}
