export_reactome <- function(driver,reactome){

library(enrichplot)
library(ggplot2)
library(jsonlite)

outdir <- file.path(
"results",
"evidence",
driver,
"Reactome"
)

dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)

figdir <- file.path(
"figures",
"evidence",
driver
)

dir.create(
figdir,
recursive=TRUE,
showWarnings=FALSE
)

tbl <- as.data.frame(reactome)

write.table(
tbl,
file.path(outdir,"Reactome.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

p1 <- barplot(
reactome,
showCategory=20
)

ggsave(
file.path(figdir,"Reactome_Barplot.png"),
p1,
width=9,
height=7,
dpi=300
)

p2 <- dotplot(
reactome,
showCategory=20
)

ggsave(
file.path(figdir,"Reactome_Dotplot.png"),
p2,
width=9,
height=7,
dpi=300
)

write(
toJSON(
list(
pathways=nrow(tbl)
),
pretty=TRUE,
auto_unbox=TRUE
),
file.path(outdir,"summary.json")
)

cat("Reactome export completed.\n")

}
