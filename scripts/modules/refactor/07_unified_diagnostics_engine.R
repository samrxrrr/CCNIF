library(jsonlite)

source("scripts/modules/refactor/06_unified_statistics_engine.R")

run_unified_diagnostics <- function(driver){

cat("=====================================\n")
cat("UNIFIED DIAGNOSTICS ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

stats <- run_unified_statistics(driver)

diagnostics <- list(

Metadata=list(
Driver=driver,
Pipeline="CCNIF",
Version="5.0",
Created=as.character(Sys.time())
),

EvidenceChecks=sapply(
stats[-1],
function(x)!is.null(x)
),

ModuleCount=length(stats)-1,

Complete=all(
sapply(
stats[-1],
function(x)!is.null(x)
)
)

)

cat("Diagnostics complete.\n")

diagnostics

}
