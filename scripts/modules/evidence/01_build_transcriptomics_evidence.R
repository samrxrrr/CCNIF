library(jsonlite)

build_transcriptomics_evidence <- function(driver){

cat("=====================================\n")
cat("TRANSCRIPTOMICS EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path(
"results",
"evidence",
driver
)

dir.create(
file.path(base,"Evidence"),
recursive=TRUE,
showWarnings=FALSE
)

model <- file.path(
base,
"Statistics",
"Models",
"Transcriptomics_Model.json"
)

distribution <- file.path(
base,
"Statistics",
"Distribution_Report.json"
)

if(!file.exists(model))
stop("Transcriptomics_Model.json missing")

if(!file.exists(distribution))
stop("Distribution_Report.json missing")

m <- read_json(model,simplifyVector=TRUE)
d <- read_json(distribution,simplifyVector=TRUE)

evidence <- list(

Metadata=list(
Driver=driver,
Domain="Transcriptomics",
Variable="AbsLog2FC",
Pipeline="CCNIF",
Version="3.0",
Created=as.character(Sys.time())
),

Raw=list(
Observed=m$Observed,
Direction="higher"
),

Statistics=d$Statistics$AbsLog2FC,

Diagnostics=d$Diagnostics$AbsLog2FC

)

outfile <- file.path(
base,
"Evidence",
"Transcriptomics_Evidence.json"
)

write_json(
evidence,
outfile,
pretty=TRUE,
auto_unbox=TRUE,
null="null"
)

cat("Evidence exported.\n")

TRUE

}
