prepare_string <- function(deg){

library(STRINGdb)

cat("============================================\n")
cat("Preparing STRING mapping\n")
cat("============================================\n")

string_db <- STRINGdb(
version="12",
species=9606,
score_threshold=400,
input_directory=""
)

mapped <- string_db$map(
deg,
"gene_name",
removeUnmappedRows=TRUE
)

cat("Mapped genes:",nrow(mapped),"\n")

return(
list(
db=string_db,
mapped=mapped
)
)

}
