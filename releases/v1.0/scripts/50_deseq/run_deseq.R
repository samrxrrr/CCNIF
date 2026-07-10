args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript run_deseq.R TP53")

}

driver_gene <- args[1]

source("scripts/50_deseq/modules/99_load_config.R")
source("scripts/50_deseq/modules/03_run_deseq.R")
source("scripts/50_deseq/modules/04_lfc_shrink.R")
source("scripts/50_deseq/modules/05_export_matrices.R")
source("scripts/50_deseq/modules/04_make_plots.R")
source("scripts/50_deseq/modules/05_export_results.R")

cat("============================================\n")
cat("CCNIF Transcriptomic Evidence Engine v2\n")
cat("============================================\n")
cat("Driver Gene :",driver_gene,"\n\n")

cfg <- load_config()

print(cfg$project)

result <- run_deseq(driver_gene)

shrunk <- shrink_lfc(result$dds)

vsd <- export_matrices(
    result$dds,
    driver_gene
)

make_plots(
    driver_gene,
    shrunk
)

summary <- export_results(
    driver_gene,
    result$results,
    result$design
)

print(summary)

cat("\n")
cat("============================================\n")
cat("Evidence Engine Completed\n")
cat("============================================\n")
