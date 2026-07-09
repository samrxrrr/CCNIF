library(jsonlite)

source("scripts/modules/refactor/05_load_unified_evidence.R")

run_unified_statistics <- function(driver){

cat("=====================================\n")
cat("UNIFIED STATISTICS ENGINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

evidence <- load_unified_evidence(driver)

stats <- list(

Metadata=list(

Driver=driver,
Pipeline="CCNIF",
Version="5.0",
Created=as.character(Sys.time())

),

Transcriptomics=evidence$Transcriptomics,

Clinical=evidence$Clinical,

Functional=evidence$Functional,

Network=evidence$Network,

Survival=evidence$Survival,

Enrichment=evidence$Enrichment

)

cat("Unified statistics object built.\n")

stats

}
