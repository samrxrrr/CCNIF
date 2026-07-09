source("scripts/modules/pipeline/01_build_statistics.R")
source("scripts/modules/pipeline/02_build_normalization.R")
source("scripts/modules/pipeline/03_build_quality.R")
source("scripts/modules/pipeline/04_build_confidence.R")

build_driver_package <- function(driver){

cat("=====================================\n")
cat("CCNIF DRIVER PACKAGE\n")
cat("=====================================\n")

build_statistics(driver)

build_normalization_pipeline(driver)

build_quality_pipeline(driver)

build_confidence_pipeline(driver)

cat("\nDriver package complete.\n")

TRUE

}
