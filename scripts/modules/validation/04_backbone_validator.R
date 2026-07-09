library(jsonlite)

check_file <- function(f){

list(

File=f,

Exists=file.exists(f)

)

}

validate_backbone <- function(driver){

base <- file.path("results","evidence",driver,"Statistics")

checks <- list(

Statistics=check_file(file.path(base,"Models","Transcriptomics_Model.json")),

Diagnostics=check_file(file.path(base,"Diagnostics","Transcriptomics_Diagnostics.json")),

DistributionReport=check_file(file.path(base,"Distribution_Report.json")),

ReliabilityReport=check_file(file.path(base,"Reliability_Report.json")),

Manifest=check_file(file.path(base,"Distribution_Manifest.json")),

ECDF=check_file(file.path(base,"ECDF","Transcriptomics_AbsLog2FC_ECDF.tsv")),

ECDF_QC=check_file(file.path(base,"ECDF_QC","Master_ECDF_Report.json"))

)

passed <- sum(vapply(checks,function(x)x$Exists,logical(1)))

failed <- length(checks)-passed

list(

BackboneReady=(failed==0),

Passed=passed,

Failed=failed,

Checks=checks

)

}
