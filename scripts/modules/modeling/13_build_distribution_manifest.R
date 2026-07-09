library(jsonlite)

file_entry <- function(path){

list(

File=path,

Exists=file.exists(path),

Size=if(file.exists(path)) file.info(path)$size else NA,

Modified=if(file.exists(path))
as.character(file.info(path)$mtime)
else NA

)

}

build_distribution_manifest <- function(base){

list(

Metadata=list(

Version="1.0",

Created=as.character(Sys.time())

),

Statistics=file_entry(

file.path(base,

"Statistics",

"Models",

"Transcriptomics_Model.json")

),

Diagnostics=file_entry(

file.path(base,

"Statistics",

"Diagnostics",

"Transcriptomics_Diagnostics.json")

),

ECDF=file_entry(

file.path(base,

"Statistics",

"ECDF",

"Transcriptomics_AbsLog2FC_ECDF.tsv")

),

DistributionReport=file_entry(

file.path(base,

"Statistics",

"Distribution_Report.json")

),

ReliabilityReport=file_entry(

file.path(base,

"Statistics",

"Reliability_Report.json")

)

)

}
