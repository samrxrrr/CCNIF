export_go <- function(go, driver_gene){

library(clusterProfiler)
library(jsonlite)

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
    as.data.frame(go$BP),
    file.path(outdir,"GO_BP.tsv"),
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)

write.table(
    as.data.frame(go$MF),
    file.path(outdir,"GO_MF.tsv"),
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)

write.table(
    as.data.frame(go$CC),
    file.path(outdir,"GO_CC.tsv"),
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)

write.table(
    go$mapping,
    file.path(outdir,"Gene_ID_Mapping.tsv"),
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)

summary <- list(
    filtered_genes = nrow(go$filtered),
    mapped_genes = nrow(go$mapping),
    BP_terms = nrow(as.data.frame(go$BP)),
    MF_terms = nrow(as.data.frame(go$MF)),
    CC_terms = nrow(as.data.frame(go$CC))
)

write(
    toJSON(summary, pretty=TRUE, auto_unbox=TRUE),
    file.path(outdir,"summary.json")
)

if(nrow(as.data.frame(go$BP)) > 0){

png(
file.path(figdir,"GO_BP_Dotplot.png"),
width=1800,
height=1400,
res=220
)

print(dotplot(go$BP, showCategory=20))

dev.off()

png(
file.path(figdir,"GO_BP_Barplot.png"),
width=1800,
height=1400,
res=220
)

print(barplot(go$BP, showCategory=20))

dev.off()

}

cat("GO export completed.\n")

}
