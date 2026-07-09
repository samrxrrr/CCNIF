library(jsonlite)

source("scripts/modules/refactor/05_load_unified_evidence.R")
source("scripts/modules/reliability/04_build_reliability.R")

run_unified_reliability <- function(driver){

cat("=====================================\n")
cat("UNIFIED RELIABILITY ENGINE\n")
cat("=====================================\n")

load_unified_evidence(driver)

build_reliability(driver)

}
