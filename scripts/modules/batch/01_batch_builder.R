library(data.table)

source("scripts/run_ccnif.R")

run_batch_build <- function(){

cat("=====================================\n")
cat("CCNIF BATCH BUILD\n")
cat("=====================================\n")

queue <- fread("results/registry/Driver_Queue.tsv")

summary <- list()

for(i in seq_len(nrow(queue))){

driver <- queue$gene_name[i]

cat("\n-------------------------------------\n")
cat("Driver:",driver,"\n")
cat("-------------------------------------\n")

status <- tryCatch({

run_ccnif(driver)

"SUCCESS"

},error=function(e){

message(e$message)

"FAILED"

})

summary[[i]] <- data.frame(

Driver=driver,

Status=status,

stringsAsFactors=FALSE

)

}

summary <- rbindlist(summary)

dir.create("results/build",
recursive=TRUE,
showWarnings=FALSE)

fwrite(

summary,

"results/build/Batch_Build_Summary.tsv",

sep="\t"

)

cat("\n=====================================\n")
cat("BATCH COMPLETE\n")
cat("=====================================\n")

print(summary)

summary

}
