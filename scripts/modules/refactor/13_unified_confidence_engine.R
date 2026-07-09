library(jsonlite)

source("scripts/modules/refactor/12_unified_quality_engine.R")
source("scripts/modules/confidence/04_build_confidence.R")

run_unified_confidence <- function(driver){

cat("=====================================\n")
cat("UNIFIED CONFIDENCE ENGINE\n")
cat("=====================================\n")

run_unified_quality(driver)

build_confidence(driver)

}
