export_network <- function(driver,network,g){

library(jsonlite)

outdir <- file.path(
"results",
"evidence",
driver,
"STRING"
)

dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)

write.table(
network,
file.path(outdir,"STRING_Edges.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

nodes <- data.frame(
STRING_id=V(g)$name
)

write.table(
nodes,
file.path(outdir,"STRING_Nodes.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

summary <- list(
nodes=vcount(g),
edges=ecount(g),
density=edge_density(g)
)

write(
toJSON(summary,
pretty=TRUE,
auto_unbox=TRUE),
file.path(outdir,"summary.json")
)

cat("Network exported.\n")

}
