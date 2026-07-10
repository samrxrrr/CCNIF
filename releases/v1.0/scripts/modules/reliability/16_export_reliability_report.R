library(jsonlite)

export_reliability_report <- function(report,file){

dir.create(

dirname(file),

recursive=TRUE,

showWarnings=FALSE

)

write_json(

report,

file,

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Reliability report exported.\n")

}
