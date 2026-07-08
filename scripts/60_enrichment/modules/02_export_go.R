export_go <- function(go_results, driver_gene){

library(clusterProfiler)

outdir <- file.path(
"results",
"evidence",
driver_gene,
"GO"
)

figdir <- file.path(
"figures",
"evidence",
driver_gene
)

dir.create(outdir, recursive=TRUE, showWarnings=FALSE)
dir.create(figdir, recursive=TRUE, showWarnings=FALSE)

write.table(
as.data.frame(go_results$BP),
file.path(outdir,"GO_BP.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

write.table(
as.data.frame(go_results$MF),
file.path(outdir,"GO_MF.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

write.table(
as.data.frame(go_results$CC),
file.path(outdir,"GO_CC.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

png(
file.path(figdir,"GO_BP_Dotplot.png"),
width=1800,
height=1400,
res=220
)

print(dotplot(go_results$BP, showCategory=20))

dev.off()

png(
file.path(figdir,"GO_BP_Barplot.png"),
width=1800,
height=1400,
res=220
)

print(barplot(go_results$BP, showCategory=20))

dev.off()

cat("GO enrichment exported.\n")

}
