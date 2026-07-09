library(jsonlite)

source("scripts/modules/dynamic/01_extract_driver_values.R")
source("scripts/modules/normalization/09_build_normalization.R")

build_normalization_pipeline <- function(driver){

cat("=====================================\n")
cat("NORMALIZATION PIPELINE\n")
cat("=====================================\n")

x <- extract_driver_values(driver)

ecdf_file <- file.path(
"results",
"evidence",
driver,
"Statistics",
"ECDF",
"Transcriptomics_AbsLog2FC_ECDF.tsv"
)

if(!file.exists(ecdf_file))
stop(paste("Missing ECDF:",ecdf_file))

report <- build_normalization(

driver=driver,

domain=x$Domain,

variable=x$Variable,

value=x$Observed,

ecdf_file=ecdf_file

)

write_json(

report,

file.path(
"results",
"evidence",
driver,
"Statistics",
"Normalization_Report.json"
),

pretty=TRUE,
auto_unbox=TRUE

)

cat("Normalization exported.\n")

return(report)

}
