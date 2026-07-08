prepare_ranking <- function(deg){

deg <- deg[!is.na(deg$padj), ]

deg <- deg[!is.na(deg$log2FoldChange), ]

deg$ranking_score <-
sign(deg$log2FoldChange) *
(-log10(deg$padj + 1e-300))

ranking <- deg[,c("gene_name","ranking_score")]

ranking <- ranking[
!duplicated(ranking$gene_name),
]

ranking <- ranking[
order(ranking$ranking_score,
decreasing=TRUE),
]

ranks <- ranking$ranking_score

names(ranks) <- ranking$gene_name

return(ranks)

}
