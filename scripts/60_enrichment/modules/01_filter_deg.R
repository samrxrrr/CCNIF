filter_deg <- function(deg_table){

source("scripts/50_deseq/modules/99_load_config.R")

cfg <- load_config()

padj_cutoff <- cfg$enrichment$padj_cutoff
lfc_cutoff  <- cfg$deseq2$log2fc_cutoff

cat("============================================\n")
cat("Filtering DEGs\n")
cat("============================================\n")

deg_table <- subset(
    deg_table,
    gene_type == "protein_coding"
)

deg_table <- subset(
    deg_table,
    !is.na(padj)
)

deg_table <- subset(
    deg_table,
    padj < padj_cutoff
)

deg_table <- subset(
    deg_table,
    abs(log2FoldChange) >= lfc_cutoff
)

cat("Protein-coding significant genes:", nrow(deg_table), "\n")

return(deg_table)

}
