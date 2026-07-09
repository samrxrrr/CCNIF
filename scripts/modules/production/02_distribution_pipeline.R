library(jsonlite)

source("scripts/modules/refactor/08_unified_distribution_engine.R")

build_distribution_pipeline <- function(driver){

cat("=====================================\n")
cat("DISTRIBUTION PIPELINE\n")
cat("=====================================\n")

run_unified_distribution(driver)

cat("Distribution completed.\n")

TRUE

}
