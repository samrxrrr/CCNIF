library(jsonlite)

source("scripts/modules/refactor/11_unified_normalization_engine.R")
source("scripts/modules/quality/07_build_quality.R")

run_unified_quality <- function(driver){

cat("=====================================\n")
cat("UNIFIED QUALITY ENGINE\n")
cat("=====================================\n")

run_unified_normalization(driver)

build_quality(driver)

}
