load_deg <- function(driver){

cat("============================================\n")
cat("Loading significant DEGs\n")
cat("============================================\n")

file <- file.path(
"results",
"evidence",
driver,
"transcriptomics",
"Significant_DEGs.tsv"
)

if(!file.exists(file))
stop("Significant_DEGs.tsv not found.")

deg <- read.delim(
file,
check.names = FALSE,
stringsAsFactors = FALSE
)

deg <- deg[
deg$gene_type=="protein_coding",
]

deg <- deg[
!is.na(deg$gene_name),
]

deg <- deg[
!duplicated(deg$gene_name),
]

cat("Genes loaded:",nrow(deg),"\n")

return(deg)

}
