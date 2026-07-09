library(jsonlite)

source("scripts/modules/refactor/10_unified_reliability_engine.R")
source("scripts/modules/normalization/09_build_normalization.R")

run_unified_normalization <- function(driver){

cat("=====================================\n")
cat("UNIFIED NORMALIZATION ENGINE\n")
cat("=====================================\n")

run_unified_reliability(driver)

build_normalization(driver)

}
