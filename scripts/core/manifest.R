library(jsonlite)

write_manifest <- function(driver){

outfile <- file.path(
"results",
"evidence",
driver$metadata$name,
"Driver_Manifest.json"
)

dir.create(
dirname(outfile),
recursive=TRUE,
showWarnings=FALSE
)

driver_json <- unclass(driver)

write_json(
driver_json,
outfile,
pretty=TRUE,
auto_unbox=TRUE,
null="null"
)

cat("Manifest written.\n")

}
