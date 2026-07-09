library(jsonlite)

source("scripts/modules/refactor/01_dynamic_normalization.R")
source("scripts/modules/normalization/09_build_normalization.R")
source("scripts/modules/normalization/08_normalization_manifest.R")
source("scripts/modules/normalization/10_export_normalization.R")

build_normalization_pipeline <- function(driver){

cat("=====================================\n")
cat("NORMALIZATION PIPELINE\n")
cat("=====================================\n")

base <- file.path("results","evidence",driver,"Statistics")

x <- extract_driver_values(driver)

ecdf <- file.path(
base,
"ECDF",
paste0(
x$Domain,
"_",
x$Variable,
"_ECDF.tsv"
)
)

report <- build_normalization(

driver=driver,
domain=x$Domain,
variable=x$Variable,
value=x$Observed,
ecdf_file=ecdf

)

manifest <- new_normalization_manifest()

manifest$NormalizationReport <-
file.path(base,"Normalization_Report.json")

manifest$ECDF <- ecdf

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

cat("Normalization exported.\n")

TRUE

}
