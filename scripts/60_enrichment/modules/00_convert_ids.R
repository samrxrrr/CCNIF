convert_gene_ids <- function(deg_table){

library(clusterProfiler)
library(org.Hs.eg.db)

cat("============================================\n")
cat("Converting Gene IDs\n")
cat("============================================\n")

deg_table <- deg_table[!is.na(deg_table$gene_name), ]

symbols <- unique(deg_table$gene_name)

symbols <- symbols[symbols != ""]

mapping <- bitr(
    symbols,
    fromType = "SYMBOL",
    toType = c("ENTREZID","ENSEMBL"),
    OrgDb = org.Hs.eg.db
)

mapping <- mapping[!duplicated(mapping$SYMBOL), ]

cat("Input symbols :", length(symbols), "\n")
cat("Mapped genes  :", nrow(mapping), "\n")

return(mapping)

}
