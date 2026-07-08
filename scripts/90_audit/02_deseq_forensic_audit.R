library(DESeq2)
library(jsonlite)

cat("=====================================================\n")
cat("CCNIF DESeq2 FORENSIC AUDIT\n")
cat("=====================================================\n\n")

counts <- read.delim(
    "data/processed/deseq/counts.tsv",
    row.names = 1,
    check.names = FALSE
)

design <- read.delim(
    "data/processed/deseq/design_TP53.tsv"
)

rownames(design) <- design$patient_id

design <- design[colnames(counts), , drop=FALSE]

dds <- DESeqDataSetFromMatrix(
    countData = counts,
    colData = design,
    design = ~ TP53_status
)

cat("Raw genes:", nrow(dds), "\n")
cat("Samples:", ncol(dds), "\n\n")

raw_genes <- nrow(dds)

keep <- rowSums(counts(dds) >= 10) >= 10

dds <- dds[keep, ]

filtered_genes <- nrow(dds)

cat("Genes after prefilter:", filtered_genes, "\n")

dds <- DESeq(dds)

res <- results(dds)

tested <- sum(!is.na(res$pvalue))

significant <- sum(
    res$padj < 0.05,
    na.rm = TRUE
)

up <- sum(
    res$padj < 0.05 &
    res$log2FoldChange > 1,
    na.rm = TRUE
)

down <- sum(
    res$padj < 0.05 &
    res$log2FoldChange < -1,
    na.rm = TRUE
)

disp <- dispersions(dds)

summary <- list(

raw_genes=raw_genes,

genes_after_prefilter=filtered_genes,

genes_tested=tested,

significant=significant,

upregulated=up,

downregulated=down,

mean_dispersion=mean(disp),

median_dispersion=median(disp)

)

cat("\n")

print(summary)

write_json(

summary,

"results/audit/deseq_forensic_summary.json",

pretty=TRUE,

auto_unbox=TRUE

)

png(

"figures/audit/Dispersion_DESeq2.png",

width=1600,

height=1200,

res=200

)

plotDispEsts(dds)

dev.off()

vsd <- vst(dds)

png(

"figures/audit/PCA_DESeq2.png",

width=1600,

height=1200,

res=200

)

plotPCA(vsd,intgroup="TP53_status")

dev.off()

saveRDS(

dds,

"results/audit/TP53_dds.rds"

)

cat("\nAudit complete.\n")
