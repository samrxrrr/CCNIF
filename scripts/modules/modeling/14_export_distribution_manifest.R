library(jsonlite)

export_distribution_manifest <- function(manifest,file){

dir.create(
dirname(file),
recursive=TRUE,
showWarnings=FALSE
)

write_json(
manifest,
file,
pretty=TRUE,
auto_unbox=TRUE,
null="null"
)

cat("Distribution manifest exported.\n")

}
