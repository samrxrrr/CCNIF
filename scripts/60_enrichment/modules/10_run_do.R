run_do <- function(map){

library(DOSE)

cat("============================================\n")
cat("Running Disease Ontology\n")
cat("============================================\n")

gene_ids <- unique(na.omit(map$ENTREZID))

do_result <- enrichDO(
    gene = gene_ids,
    ont = "HDO",
    organism = "hsa",
    pvalueCutoff = 0.05,
    pAdjustMethod = "BH",
    qvalueCutoff = 0.05,
    readable = TRUE
)

return(do_result)

}
