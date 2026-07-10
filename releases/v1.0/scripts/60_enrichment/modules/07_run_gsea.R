run_gsea <- function(ranks){

library(fgsea)
library(msigdbr)

source("scripts/50_deseq/modules/99_load_config.R")

cfg <- load_config()

cat("============================================\n")
cat("Loading Hallmark Gene Sets\n")
cat("============================================\n")

hallmark <- msigdbr(
    species = cfg$enrichment$organism,
    category = cfg$gsea$collection
)

pathways <- split(
    hallmark$gene_symbol,
    hallmark$gs_name
)

cat("Gene sets:", length(pathways), "\n")

fg <- fgsea(
    pathways = pathways,
    stats = ranks,
    minSize = cfg$gsea$minSize,
    maxSize = cfg$gsea$maxSize,
    eps = 0
)

fg <- fg[order(fg$padj),]

return(fg)

}
