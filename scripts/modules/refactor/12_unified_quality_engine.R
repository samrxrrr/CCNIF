source("scripts/modules/production/05_quality_pipeline.R")

run_unified_quality <- function(driver){

cat("=====================================\n")
cat("UNIFIED QUALITY\n")
cat("=====================================\n")

build_quality_pipeline(driver)

}
