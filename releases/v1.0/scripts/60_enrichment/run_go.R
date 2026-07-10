args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript run_go.R TP53")

}

driver_gene <- args[1]

source("scripts/60_enrichment/framework/00_prepare_transcriptomics.R")
prepare_transcriptomics(driver_gene)


source("scripts/60_enrichment/modules/02_go_enrichment.R")
source("scripts/60_enrichment/modules/03_export_go.R")

deg <- read.delim(
paste0(
"results/evidence/",
driver_gene,
"/transcriptomics/DEGs.tsv"
),
check.names=FALSE
)

go <- run_go(deg)

export_go(
go,
driver_gene
)

cat("\n=====================================\n")
cat("GO enrichment completed successfully\n")
cat("=====================================\n")