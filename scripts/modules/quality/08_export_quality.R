library(jsonlite)

export_quality <- function(

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

file.path(base,"Quality_Report.json"),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

write_json(

manifest,

file.path(base,"Quality_Manifest.json"),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Quality exported.\n")

}
