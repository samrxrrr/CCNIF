library(data.table)

build_driver_registry <- function(){

deg_file <- "data/DEGs.tsv"

if(!file.exists(deg_file))
stop("Missing data/DEGs.tsv")

deg <- fread(deg_file)

gene_col <- c("gene_name","Gene","SYMBOL","symbol")
gene_col <- gene_col[gene_col %in% names(deg)]

if(length(gene_col)==0)
stop("No gene symbol column found.")

gene_col <- gene_col[1]

drivers <- unique(as.character(deg[[gene_col]]))
drivers <- sort(drivers)

registry <- data.frame(

Driver=drivers,

Evidence=FALSE,
Statistics=FALSE,
Reliability=FALSE,
Normalization=FALSE,
Quality=FALSE,
Confidence=FALSE,
Report=FALSE,
Atlas=FALSE,

stringsAsFactors=FALSE

)

dir.create("results/registry",
recursive=TRUE,
showWarnings=FALSE)

write.table(

registry,

"results/registry/Driver_Registry.tsv",

sep="\t",
quote=FALSE,
row.names=FALSE

)

cat("=====================================\n")
cat("DRIVER REGISTRY BUILT\n")
cat("=====================================\n")
cat("Drivers:",nrow(registry),"\n")

registry

}
