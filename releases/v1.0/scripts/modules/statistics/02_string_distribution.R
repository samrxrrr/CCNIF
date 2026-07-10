build_string_distribution <- function(driver){

cat("============================================\n")
cat("STRING Distribution Engine\n")
cat("============================================\n")

base <- file.path("results","evidence",driver)

net <- read.delim(
file.path(base,"STRING","Network_Metrics.tsv"),
check.names=FALSE
)

net <- net[order(-net$CompositeScore),]

net$Rank <- seq_len(nrow(net))

net$Percentile <- round(
(net$Rank-1)/(nrow(net)-1),
6
)

out <- net[,c(
"Gene",
"STRING_id",
"Degree",
"Betweenness",
"Closeness",
"Eigenvector",
"PageRank",
"CompositeScore",
"Rank",
"Percentile"
)]

dir.create(
file.path(base,"Statistics"),
recursive=TRUE,
showWarnings=FALSE
)

write.table(
out,
file.path(
base,
"Statistics",
"STRING_Distribution.tsv"
),
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("Rows exported :",nrow(out),"\n")
cat("Distribution exported.\n")

}
