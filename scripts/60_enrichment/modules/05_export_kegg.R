export_kegg <- function(kegg, driver_gene){

library(clusterProfiler)
library(jsonlite)

outdir <- file.path(
    "results",
    "evidence",
    driver_gene,
    "KEGG"
)

figdir <- file.path(
    "figures",
    "evidence",
    driver_gene
)

dir.create(outdir, recursive=TRUE, showWarnings=FALSE)
dir.create(figdir, recursive=TRUE, showWarnings=FALSE)

write.table(
    as.data.frame(kegg),
    file.path(outdir,"KEGG.tsv"),
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)

summary <- list(
    pathways = nrow(as.data.frame(kegg))
)

write(
    toJSON(summary, pretty=TRUE, auto_unbox=TRUE),
    file.path(outdir,"summary.json")
)

if(nrow(as.data.frame(kegg)) > 0){

png(
file.path(figdir,"KEGG_Dotplot.png"),
width=1800,
height=1400,
res=220
)

print(dotplot(kegg, showCategory=20))

dev.off()

png(
file.path(figdir,"KEGG_Barplot.png"),
width=1800,
height=1400,
res=220
)

print(barplot(kegg, showCategory=20))

dev.off()

}

cat("KEGG export completed.\n")

}
