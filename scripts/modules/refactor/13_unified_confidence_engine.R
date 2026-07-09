
source("scripts/modules/refactor/10_unified_reliability_engine.R")
source("scripts/modules/refactor/11_unified_normalization_engine.R")
source("scripts/modules/refactor/12_unified_quality_engine.R")
source("scripts/modules/production/06_confidence_pipeline.R")

run_unified_confidence <- function(driver){

cat("=====================================\n")
cat("UNIFIED CONFIDENCE ENGINE\n")
cat("=====================================\n")

run_unified_reliability(driver)

run_unified_normalization(driver)

run_unified_quality(driver)

build_confidence_pipeline(driver)

}
