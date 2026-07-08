community_detection <- function(g){

library(igraph)

cat("============================================\n")
cat("Running Community Detection\n")
cat("============================================\n")

comm <- cluster_louvain(g)

membership_tbl <- data.frame(

STRING_id=V(g)$name,

Gene=V(g)$gene_name,

Community=membership(comm),

stringsAsFactors=FALSE

)

summary_tbl <- data.frame(

Community=sort(unique(membership(comm)))

)

summary_tbl$Size <- sapply(

summary_tbl$Community,

function(x){

sum(membership(comm)==x)

}

)

list(

membership=membership_tbl,

summary=summary_tbl,

object=comm

)

}
