library(jsonlite)

source("scripts/modules/normalization/09_build_normalization.R")
source("scripts/modules/normalization/08_normalization_manifest.R")
source("scripts/modules/normalization/10_export_normalization.R")

build_normalization_pipeline <- function(driver){

cat("=====================================\n")
cat("NORMALIZATION PIPELINE\n")
cat("=====================================\n")

base <- file.path("results","evidence",driver,"Statistics")

ecdf <- file.path(
base,
"ECDF",
"Transcriptomics_AbsLog2FC_ECDF.tsv"
)

if(!file.exists(ecdf)){

dir.create(dirname(ecdf),recursive=TRUE,showWarnings=FALSE)

dist <- read_json(
file.path(base,"Distribution_Report.json"),
simplifyVector=TRUE
)

write.table(
dist$RawData$AbsLog2FC,
ecdf,
sep="\t",
row.names=FALSE,
col.names=FALSE,
quote=FALSE
)

cat("ECDF generated.\n")

}

evidence <- read_json(
file.path(
"results",
"evidence",
driver,
"Evidence",
"Transcriptomics_Evidence.json"
),
simplifyVector=TRUE
)

report <- build_normalization(

driver=driver,
domain="Transcriptomics",
variable="AbsLog2FC",
value=evidence$Raw$Observed,
ecdf_file=ecdf

)

manifest <- new_normalization_manifest()

manifest$NormalizationReport <- file.path(base,"Normalization_Report.json")
manifest$ECDF <- ecdf
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

cat("Normalization exported.\n")

TRUE

}
