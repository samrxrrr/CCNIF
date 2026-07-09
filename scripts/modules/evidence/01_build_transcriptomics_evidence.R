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

dist <- read_json(
file.path(base,
"Statistics",
"Distribution_Report.json"),
simplifyVector=TRUE
)

drv <- extract_driver_record(driver)

evidence <- list(

Metadata=list(
Driver=driver,
Domain="Transcriptomics",
Variable="AbsLog2FC",
Pipeline="CCNIF",
Version="4.0",
Created=as.character(Sys.time())
),

Raw=list(
Observed=drv$Observed,
Direction="higher"
),

Driver=drv,

Statistics=dist$Statistics$AbsLog2FC,

Diagnostics=dist$Diagnostics$AbsLog2FC

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
