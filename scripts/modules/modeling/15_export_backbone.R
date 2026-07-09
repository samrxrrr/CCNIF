library(jsonlite)

export_backbone <- function(backbone,file){

dir.create(dirname(file),

recursive=TRUE,

showWarnings=FALSE)

write_json(

backbone,

file,

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Mathematical backbone exported.\n")

}
