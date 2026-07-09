library(jsonlite)

export_confidence <- function(

report,
manifest,
base

){

dir.create(

base,

recursive=TRUE,

showWarnings=FALSE

)

write_json(

report,

file.path(base,"Confidence_Report.json"),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

write_json(

manifest,

file.path(base,"Confidence_Manifest.json"),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Confidence exported.\n")

}
