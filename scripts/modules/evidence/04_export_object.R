library(jsonlite)

export_evidence_object <- function(object,file){

dir.create(dirname(file),
recursive=TRUE,
showWarnings=FALSE
)

write_json(

object,

file,

pretty=TRUE,

auto_unbox=TRUE

)

cat("Evidence object exported.\n")

}
