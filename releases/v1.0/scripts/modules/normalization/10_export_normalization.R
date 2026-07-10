library(jsonlite)

export_normalization <- function(

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

file.path(base,"Normalization_Report.json"),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

write_json(

manifest,

file.path(base,"Normalization_Manifest.json"),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Normalization exported.\n")

}
