source("scripts/modules/quality/07_build_quality.R")

build_quality_pipeline <- function(driver){

cat("=====================================\n")
cat("QUALITY PIPELINE\n")
cat("=====================================\n")

result <- build_quality(driver)

cat("Quality complete.\n")

result

}
