source("scripts/modules/normalization/09_build_normalization.R")

build_normalization_pipeline <- function(driver){

cat("=====================================\n")
cat("NORMALIZATION PIPELINE\n")
cat("=====================================\n")

result <- build_normalization(driver)

cat("Normalization complete.\n")

result

}
