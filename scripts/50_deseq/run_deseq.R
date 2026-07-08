args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript run_deseq.R TP53")

}

driver_gene <- args[1]

source("scripts/50_deseq/modules/03_run_deseq.R")
source("scripts/50_deseq/modules/04_make_plots.R")
source("scripts/50_deseq/modules/05_export_results.R")

cat("============================================\n")
cat("CCNIF Transcriptomic Evidence Engine\n")
cat("============================================\n")

result <- run_deseq(driver_gene)

make_plots(
driver_gene,
result$deseq_results
)

summary <- export_results(
driver_gene,
result$results,
result$design
)

print(summary)
