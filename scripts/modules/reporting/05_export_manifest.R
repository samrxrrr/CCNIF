library(jsonlite)

export_driver_manifest <- function(

manifest,
driver

){

write_json(

manifest,

file.path(

"results",
"evidence",
driver,
"Driver_Manifest.json"

),

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Driver manifest exported.\n")

}
