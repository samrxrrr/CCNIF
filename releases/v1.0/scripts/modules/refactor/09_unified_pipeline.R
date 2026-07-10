library(jsonlite)

source("scripts/modules/refactor/08_unified_distribution_engine.R")

run_unified_pipeline <- function(driver){

cat("=====================================\n")
cat("CCNIF UNIFIED PIPELINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

dist <- run_unified_distribution(driver)

if(!dist$Summary$Complete)
stop("Unified diagnostics failed.")

cat("\nUnified pipeline completed successfully.\n")

list(

Driver=driver,

Status="SUCCESS",

EvidenceModules=dist$Summary$EvidenceModules,

Passed=dist$Summary$Passed,

Failed=dist$Summary$Failed,

Timestamp=as.character(Sys.time())

)

}
