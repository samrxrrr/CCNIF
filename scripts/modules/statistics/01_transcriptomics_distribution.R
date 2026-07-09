build_transcriptomics_distribution <- function(driver){

cat("============================================\n")
cat("Transcriptomics Distribution Engine\n")
cat("============================================\n")

base <- file.path("results","evidence",driver)

deg <- read.delim(
file.path(base,"transcriptomics","DEGs.tsv"),
check.names=FALSE
)

deg$AbsLog2FC <- abs(deg$log2FoldChange)

deg <- deg[order(-deg$AbsLog2FC),]

deg$Rank <- seq_len(nrow(deg))

deg$Percentile <- round(
100*(deg$Rank-1)/(nrow(deg)-1),
4
)

cols <- c(
"gene_name",
"gene_id",
"log2FoldChange",
"AbsLog2FC",
"padj",
"baseMean",
"Rank",
"Percentile"
)

out <- deg[,cols]

names(out) <- c(
"Gene",
"GeneID",
"log2FC",
"AbsLog2FC",
"padj",
"baseMean",
"Rank",
"Percentile"
)

dir.create(
file.path(base,"Statistics"),
recursive=TRUE,
showWarnings=FALSE
)

write.table(
out,
file.path(
base,
"Statistics",
"Transcriptomics_Distribution.tsv"
),
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("Rows exported :",nrow(out),"\n")
cat("Distribution exported.\n")

}
