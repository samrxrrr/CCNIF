run_kegg <- function(mapping){

library(clusterProfiler)

cat("============================================\n")
cat("Running KEGG enrichment\n")
cat("============================================\n")

kk <- enrichKEGG(
    gene = unique(mapping$ENTREZID),
    organism = "hsa",
    keyType = "ncbi-geneid",
    pAdjustMethod = "BH",
    pvalueCutoff = 0.05,
    qvalueCutoff = 0.05
)

kk <- setReadable(
    kk,
    OrgDb = org.Hs.eg.db,
    keyType = "ENTREZID"
)

cat("KEGG pathways:", nrow(as.data.frame(kk)), "\n")

return(kk)

}
