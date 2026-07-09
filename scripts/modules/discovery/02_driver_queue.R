library(data.table)

build_driver_queue <- function(top_n=100){

cat("=====================================\n")
cat("BUILD DRIVER QUEUE\n")
cat("=====================================\n")

drivers <- fread("results/drivers/top50_drivers.tsv")

queue <- head(drivers, top_n)

dir.create(
"results/registry",
recursive=TRUE,
showWarnings=FALSE
)

fwrite(
queue,
"results/registry/Driver_Queue.tsv",
sep="\t"
)

cat("Queued drivers:", nrow(queue), "\n")

queue

}
