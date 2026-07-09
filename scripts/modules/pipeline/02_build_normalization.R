library(jsonlite)

source("scripts/modules/normalization/09_build_normalization.R")
source("scripts/modules/normalization/08_normalization_manifest.R")
source("scripts/modules/normalization/10_export_normalization.R")

build_normalization_pipeline <- function(driver){

cat("Building normalization...\n")

base <- file.path("results","evidence",driver,"Statistics")

ecdf <- file.path(
base,
"ECDF",
"Transcriptomics_AbsLog2FC_ECDF.tsv"
)

if(!file.exists(ecdf)){

cat("ECDF missing. Skipping normalization.\n")

return(FALSE)

}

report <- build_normalization(

driver=driver,
domain="Transcriptomics",
variable="AbsLog2FC",
value=2.5,
ecdf_file=ecdf

)

manifest <- new_normalization_manifest()

manifest$NormalizationReport <-
file.path(base,"Normalization_Report.json")

manifest$ECDF <- ecdf

manifest$Registry <-
"config/variable_registry.tsv"

manifest$Evidence <-
file.path(
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
