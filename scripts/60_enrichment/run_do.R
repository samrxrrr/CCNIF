args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript run_do.R TP53")

}

driver_gene <- args[1]

source("scripts/60_enrichment/framework/00_prepare_transcriptomics.R")
prepare_transcriptomics(driver_gene)


source("scripts/60_enrichment/modules/01_filter_deg.R")
source("scripts/60_enrichment/modules/00_convert_ids.R")
source("scripts/60_enrichment/modules/10_run_do.R")
source("scripts/60_enrichment/modules/11_export_do.R")

deg <- read.delim(
paste0(
"results/evidence/",
driver_gene,
"/transcriptomics/DEGs.tsv"
),
check.names=FALSE
)

deg <- filter_deg(deg)

map <- convert_gene_ids(deg)

do_result <- run_do(map)

export_do(
do_result,
driver_gene,
map
)

cat("\n=====================================\n")
cat("Disease Ontology completed\n")
cat("=====================================\n")