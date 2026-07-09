library(jsonlite)

source("scripts/modules/refactor/07_unified_diagnostics_engine.R")

run_unified_distribution <- function(driver){

cat("=====================================\n")
cat("UNIFIED DISTRIBUTION ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

diag <- run_unified_diagnostics(driver)

distribution <- list(

Metadata=list(
Driver=driver,
Pipeline="CCNIF",
Version="5.0",
Created=as.character(Sys.time())
),

Diagnostics=diag,

Summary=list(

EvidenceModules=diag$ModuleCount,

Complete=diag$Complete,

Passed=sum(diag$EvidenceChecks),

Failed=sum(!diag$EvidenceChecks)

)

)

cat("Distribution object built.\n")

distribution

}
