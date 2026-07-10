library(jsonlite)

safe_read <- function(file){

if(!file.exists(file))
return(NULL)

read_json(

file,

simplifyVector=TRUE

)

}

build_driver_report <- function(driver){

base <- file.path(

"results",
"evidence",
driver,
"Statistics"

)

report <- new_driver_report()

report$Metadata$Driver <- driver

report$Evidence <-
safe_read(

file.path(

"results",
"evidence",
driver,
"Evidence",
"Transcriptomics_Evidence.json"

)

)

report$Statistics <-
safe_read(

file.path(

base,
"Models",
"Transcriptomics_Model.json"

)

)

report$Diagnostics <-
safe_read(

file.path(

base,
"Diagnostics",
"Transcriptomics_Diagnostics.json"

)

)

report$Normalization <-
safe_read(

file.path(

base,
"Normalization_Report.json"

)

)

report$Quality <-
safe_read(

file.path(

base,
"Quality_Report.json"

)

)

report$Confidence <-
safe_read(

file.path(

base,
"Confidence_Report.json"

)

)

report

}
