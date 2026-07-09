library(data.table)

discover_drivers <- function(){

queue_file <- file.path(
"results",
"registry",
"Driver_Queue.tsv"
)

if(!file.exists(queue_file))
stop("Driver_Queue.tsv not found.")

queue <- fread(queue_file)

if(!"gene_name" %in% names(queue))
stop("Column 'gene_name' missing in Driver_Queue.tsv")

drivers <- unique(as.character(queue$gene_name))

drivers <- drivers[drivers!=""]

cat("=====================================\n")
cat("Drivers discovered\n")
cat("=====================================\n")

print(drivers)

drivers

}
