load_clinical <- function(){

cat("============================================\n")
cat("Loading Clinical Data\n")
cat("============================================\n")

clinical <- read.delim(
"data/processed/final/clinical_master_matched.tsv",
check.names=FALSE
)

cat("Samples:",nrow(clinical),"\n")

return(clinical)

}
