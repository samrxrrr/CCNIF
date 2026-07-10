run_go <- function(gene_table){

library(clusterProfiler)
library(org.Hs.eg.db)

sig <- subset(
    gene_table,
    padj < 0.05 &
    abs(log2FoldChange) >= 1
)

genes <- unique(sig$gene_name)

genes <- genes[!is.na(genes)]

ego_bp <- enrichGO(
    gene=genes,
    OrgDb=org.Hs.eg.db,
    keyType="SYMBOL",
    ont="BP",
    pAdjustMethod="BH",
    pvalueCutoff=0.05,
    qvalueCutoff=0.05,
    readable=TRUE
)

ego_mf <- enrichGO(
    gene=genes,
    OrgDb=org.Hs.eg.db,
    keyType="SYMBOL",
    ont="MF",
    pAdjustMethod="BH",
    pvalueCutoff=0.05,
    qvalueCutoff=0.05,
    readable=TRUE
)

ego_cc <- enrichGO(
    gene=genes,
    OrgDb=org.Hs.eg.db,
    keyType="SYMBOL",
    ont="CC",
    pAdjustMethod="BH",
    pvalueCutoff=0.05,
    qvalueCutoff=0.05,
    readable=TRUE
)

list(
BP=ego_bp,
MF=ego_mf,
CC=ego_cc
)

}
