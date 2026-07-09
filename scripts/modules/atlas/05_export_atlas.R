library(jsonlite)

export_atlas <- function(atlas){

dir.create(
"results/atlas",
recursive=TRUE,
showWarnings=FALSE
)

write_json(

atlas,

"results/atlas/CCNIF_Atlas.json",

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Atlas exported.\n")

}
