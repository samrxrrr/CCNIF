run_reactome <- function(map){

library(ReactomePA)

cat("============================================\n")
cat("Running Reactome Enrichment\n")
cat("============================================\n")

gene_ids <- unique(na.omit(map$ENTREZID))

reactome <- enrichPathway(
gene=gene_ids,
organism="human",
pvalueCutoff=0.05,
pAdjustMethod="BH",
qvalueCutoff=0.05,
readable=TRUE
)

return(reactome)

}
