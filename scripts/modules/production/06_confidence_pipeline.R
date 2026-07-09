source("scripts/modules/confidence/04_build_confidence.R")

build_confidence_pipeline <- function(driver){

cat("=====================================\n")
cat("CONFIDENCE PIPELINE\n")
cat("=====================================\n")

result <- build_confidence(driver)

cat("Confidence complete.\n")

result

}
