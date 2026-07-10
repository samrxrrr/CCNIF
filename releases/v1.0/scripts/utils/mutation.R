read_mutation <- function(){

cat("============================================\n")
cat("Loading Mutation Matrix\n")
cat("============================================\n")

mutation <- read.delim(
"data/processed/final/mutation_matrix_matched.tsv",
check.names=FALSE
)

cat("Genes   :",nrow(mutation),"\n")
cat("Samples :",ncol(mutation)-1,"\n")

return(mutation)

}
