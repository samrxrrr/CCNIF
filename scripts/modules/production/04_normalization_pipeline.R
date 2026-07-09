library(jsonlite)

source("scripts/modules/normalization/09_build_normalization.R")
source("scripts/modules/normalization/08_normalization_manifest.R")
source("scripts/modules/normalization/10_export_normalization.R")

build_normalization_pipeline <- function(driver){

cat("=====================================\n")
cat("NORMALIZATION PIPELINE\n")
cat("=====================================\n")

base <- file.path("results","evidence",driver,"Statistics")

dir.create(
file.path(base,"ECDF"),
recursive=TRUE,
showWarnings=FALSE
)

ecdf_file <- file.path(
base,
"ECDF",
"Transcriptomics_AbsLog2FC_ECDF.tsv"
)

if(!file.exists(ecdf_file)){

tbl <- read.delim(
file.path(
base,
"Transcriptomics_Distribution.tsv"
),
check.names=FALSE
)

tbl <- tbl[order(tbl$AbsLog2FC),]

tbl$ECDF <- seq_len(nrow(tbl))/nrow(tbl)

write.table(
tbl[,c("AbsLog2FC","ECDF")],
ecdf_file,
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("ECDF generated.\n")

}

report <- build_normalization(

driver=driver,
domain="Transcriptomics",
variable="AbsLog2FC",
value=2.5,
ecdf_file=ecdf_file

)

manifest <- new_normalization_manifest()

manifest$NormalizationReport <- file.path(base,"Normalization_Report.json")
manifest$ECDF <- ecdf_file
manifest$Registry <- "config/variable_registry.tsv"
manifest$Evidence <- file.path(
"results",
"evidence",
driver,
"Evidence",
"Transcriptomics_Evidence.json"
)

export_normalization(
report,
manifest,
base
)

TRUE

}
