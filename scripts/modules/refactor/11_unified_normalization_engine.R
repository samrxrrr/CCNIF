source("scripts/modules/production/04_normalization_pipeline.R")

run_unified_normalization <- function(driver){

cat("=====================================\n")
cat("UNIFIED NORMALIZATION\n")
cat("=====================================\n")

build_normalization_pipeline(driver)

}
