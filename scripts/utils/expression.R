read_expression <- function(){

cat("============================================\n")
cat("Loading Expression Matrix\n")
cat("============================================\n")

expr <- read.delim(
gzfile("data/processed/final/expression_matched.tsv.gz"),
check.names=FALSE
)

cat("Genes   :",nrow(expr),"\n")
cat("Samples :",ncol(expr)-3,"\n")

return(expr)

}

extract_driver_expression <- function(expr,driver){

idx <- which(expr$gene_name==driver)

if(length(idx)!=1){

stop(
paste(
"Driver not uniquely found:",
driver
)
)

}

values <- as.numeric(expr[idx,-c(1:3)])

names(values) <- colnames(expr)[-c(1:3)]

cat("Driver :",driver,"\n")
cat("Patients:",length(values),"\n")

return(values)

}
