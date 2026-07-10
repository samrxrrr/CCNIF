library(jsonlite)

file_record <- function(path){

list(

File=path,

Exists=file.exists(path),

Size=if(file.exists(path)) file.info(path)$size else NA,

Modified=if(file.exists(path))
as.character(file.info(path)$mtime)
else NA

)

}

build_driver_manifest <- function(driver){

base <- file.path(

"results",
"evidence",
driver

)

list(

Metadata=list(

Driver=driver,

Version="1.0",

Pipeline="CCNIF",

Created=as.character(Sys.time())

),

Evidence=file_record(

file.path(base,"Evidence","Transcriptomics_Evidence.json")

),

Statistics=file_record(

file.path(base,"Statistics","Models","Transcriptomics_Model.json")

),

Diagnostics=file_record(

file.path(base,"Statistics","Diagnostics","Transcriptomics_Diagnostics.json")

),

Normalization=file_record(

file.path(base,"Statistics","Normalization_Report.json")

),

Quality=file_record(

file.path(base,"Statistics","Quality_Report.json")

),

Confidence=file_record(

file.path(base,"Statistics","Confidence_Report.json")

),

DriverReport=file_record(

file.path(base,"Driver_Report.json")

)

)

}
