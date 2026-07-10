export_gsea <- function(gsea, driver_gene){

library(jsonlite)
library(ggplot2)

outdir <- file.path(
"results",
"evidence",
driver_gene,
"GSEA"
)

figdir <- file.path(
"figures",
"evidence",
driver_gene
)

dir.create(outdir,recursive=TRUE,showWarnings=FALSE)
dir.create(figdir,recursive=TRUE,showWarnings=FALSE)

####################################################
## Separate leading edge genes
####################################################

leading <- data.frame(
Pathway=gsea$pathway,
LeadingEdge=sapply(
gsea$leadingEdge,
paste,
collapse=";"
)
)

####################################################
## Remove list column
####################################################

gsea_export <- as.data.frame(gsea)

gsea_export$leadingEdge <- NULL

####################################################
## Export tables
####################################################

write.table(
gsea_export,
file.path(outdir,"Hallmark.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

write.table(
leading,
file.path(outdir,"LeadingEdge.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

####################################################
## Summary
####################################################

summary <- list(

pathways=nrow(gsea_export),

significant=sum(
gsea_export$padj<0.05,
na.rm=TRUE
)

)

write(

toJSON(
summary,
pretty=TRUE,
auto_unbox=TRUE
),

file.path(
outdir,
"summary.json"
)

)

####################################################
## Plot
####################################################

top <- head(

gsea_export[
order(
gsea_export$NES,
decreasing=TRUE
),

],

20

)

p <- ggplot(

top,

aes(

reorder(pathway,NES),

NES

)

)+

geom_col()+

coord_flip()+

labs(

x="",

y="NES",

title="Hallmark GSEA"

)

ggsave(

file.path(
figdir,
"Hallmark_GSEA.png"
),

p,

width=10,

height=8

)

cat("GSEA exported.\n")

}
