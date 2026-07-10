export_metrics <- function(driver,metrics){

library(jsonlite)

outdir <- file.path(
"results",
"evidence",
driver,
"STRING"
)

write.table(

metrics,

file.path(
outdir,
"Network_Metrics.tsv"
),

sep="\t",

quote=FALSE,

row.names=FALSE

)

summary <- list(

nodes=nrow(metrics),

top_hub=metrics$STRING_id[1]

)

write(

toJSON(

summary,

pretty=TRUE,

auto_unbox=TRUE

),

file.path(

outdir,

"network_metrics_summary.json"

)

)

cat("Network metrics exported.\n")

}
