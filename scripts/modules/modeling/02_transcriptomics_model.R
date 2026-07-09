library(jsonlite)

source("scripts/modules/modeling/01_statistics_engine.R")

build_transcriptomics_model <- function(driver){

cat("============================================\n")
cat("Transcriptomics Statistical Model\n")
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver
)

tbl <- read.delim(
file.path(
base,
"Statistics",
"Transcriptomics_Distribution.tsv"
),
check.names=FALSE
)

model <- list(

Driver=driver,

Genes=nrow(tbl),

Log2FC=describe_numeric(tbl$log2FC),

AbsLog2FC=describe_numeric(tbl$AbsLog2FC),

Padj=describe_numeric(tbl$padj),

BaseMean=describe_numeric(tbl$baseMean)

)

dir.create(
file.path(base,"Statistics","Models"),
recursive=TRUE,
showWarnings=FALSE
)

jsonlite::write_json(
model,
file.path(
base,
"Statistics",
"Models",
"Transcriptomics_Model.json"
),
pretty=TRUE,
auto_unbox=TRUE
)

cat("Transcriptomics model exported.\n")

}
