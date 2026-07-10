export_do <- function(do_result,driver,map){

library(jsonlite)
library(ggplot2)
library(enrichplot)

outdir <- file.path(
"results",
"evidence",
driver,
"DiseaseOntology"
)

figdir <- file.path(
"figures",
"evidence",
driver
)

dir.create(outdir,recursive=TRUE,showWarnings=FALSE)
dir.create(figdir,recursive=TRUE,showWarnings=FALSE)

tbl <- as.data.frame(do_result)

write.table(
tbl,
file.path(outdir,"DiseaseOntology.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

summary <- list(

mapped_genes=nrow(map),

disease_terms=nrow(tbl)

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

if(nrow(tbl)>0){

p1 <- barplot(
do_result,
showCategory=20
)

ggsave(
file.path(
figdir,
"DO_Barplot.png"
),
p1,
width=8,
height=6
)

p2 <- dotplot(
do_result,
showCategory=20
)

ggsave(
file.path(
figdir,
"DO_Dotplot.png"
),
p2,
width=8,
height=6
)

}

cat("Disease Ontology exported.\n")

}
