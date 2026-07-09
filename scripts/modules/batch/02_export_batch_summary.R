library(jsonlite)

export_batch_summary <- function(results){

dir.create(
"results/batch",
recursive=TRUE,
showWarnings=FALSE
)

write.table(
results,
"results/batch/Batch_Summary.tsv",
sep="\t",
row.names=FALSE,
quote=FALSE
)

write_json(
list(
Drivers=nrow(results),
Successful=sum(results$Status=="SUCCESS"),
Failed=sum(results$Status!="SUCCESS")
),
"results/batch/Batch_Summary.json",
pretty=TRUE,
auto_unbox=TRUE
)

cat("Batch summary exported.\n")

}
