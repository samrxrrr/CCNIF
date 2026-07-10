library(jsonlite)

source("scripts/modules/evidence/00_extract_driver_record.R")

build_transcriptomics_evidence <- function(driver){

cat("=====================================\n")
cat("TRANSCRIPTOMICS EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path("results","evidence",driver)

dir.create(
file.path(base,"Evidence"),
recursive=TRUE,
showWarnings=FALSE
)

drv <- extract_driver_record(driver)

evidence <- list(

Metadata=list(
Driver=driver,
Domain="Transcriptomics",
Pipeline="CCNIF",
Version="5.0",
Created=as.character(Sys.time())
),

Driver=drv,

Raw=list(

Observed=drv$Observed,

Direction=ifelse(
drv$log2FC>=0,
"Upregulated",
"Downregulated"
),

AbsLog2FC=drv$AbsLog2FC,

baseMean=drv$baseMean,

padj=drv$padj,

Rank=drv$Rank,

Percentile=drv$Percentile

)

)

write_json(

evidence,

file.path(
base,
"Evidence",
"Transcriptomics_Evidence.json"
),

pretty=TRUE,
auto_unbox=TRUE,
null="null"

)

cat("Evidence exported.\n")

TRUE

}
