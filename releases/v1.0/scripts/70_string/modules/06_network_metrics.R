network_metrics <- function(g){

library(igraph)

cat("============================================\n")
cat("Computing Network Metrics\n")
cat("============================================\n")

metrics <- data.frame(

STRING_id=V(g)$name,

Gene=V(g)$gene_name,

Degree=degree(g),

Betweenness=betweenness(g,normalized=TRUE),

Closeness=closeness(g,normalized=TRUE),

Eigenvector=eigen_centrality(g)$vector,

PageRank=page_rank(g)$vector,

stringsAsFactors=FALSE

)

metrics$CompositeScore <-

scale(metrics$Degree)+
scale(metrics$Betweenness)+
scale(metrics$Closeness)+
scale(metrics$Eigenvector)+
scale(metrics$PageRank)

metrics <- metrics[
order(metrics$CompositeScore,decreasing=TRUE),
]

rownames(metrics) <- NULL

return(metrics)

}
