build_graph <- function(network,mapped){

library(igraph)

cat("============================================\n")
cat("Building igraph object\n")
cat("============================================\n")

vertices <- unique(
mapped[,c("STRING_id","gene_name")]
)

colnames(vertices) <- c("name","gene_name")

g <- graph_from_data_frame(
d = network,
vertices = vertices,
directed = FALSE
)

cat("Vertices:",vcount(g),"\n")
cat("Edges:",ecount(g),"\n")

return(g)

}
