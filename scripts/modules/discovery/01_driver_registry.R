library(data.table)

build_driver_registry <- function(){

cat("=====================================\n")
cat("BUILD DRIVER REGISTRY\n")
cat("=====================================\n")

files <- list.files(
"results/evidence",
pattern="DEGs.tsv",
recursive=TRUE,
full.names=TRUE
)

if(length(files)==0)
stop("No DEG files found.")

registry <- rbindlist(lapply(files,function(f){

x <- fread(f)

gene_col <- grep("gene_name",names(x),ignore.case=TRUE,value=TRUE)[1]

data.table(

Driver=x[[gene_col]],

Source=f

)

}),fill=TRUE)

registry <- unique(registry)

dir.create("results/registry",
recursive=TRUE,
showWarnings=FALSE)

fwrite(
registry,
"results/registry/Driver_Registry.tsv",
sep="\t"
)

cat("Drivers:",nrow(registry),"\n")

registry

}
