args <- commandArgs(trailingOnly = TRUE)

if(length(args) != 1){

    stop("Usage: Rscript run_gsea.R TP53")

}

driver_gene <- args[1]

source("scripts/60_enrichment/modules/06_prepare_ranking.R")
source("scripts/60_enrichment/modules/07_run_gsea.R")
source("scripts/60_enrichment/modules/08_export_gsea.R")

deg <- read.delim(
    paste0(
        "results/evidence/",
        driver_gene,
        "/transcriptomics/DEGs.tsv"
    ),
    check.names = FALSE
)

ranks <- prepare_ranking(deg)

gsea <- run_gsea(ranks)

export_gsea(
    gsea,
    driver_gene
)

cat("\n=====================================\n")
cat("Hallmark GSEA completed\n")
cat("=====================================\n")
