args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript run_kegg.R TP53")

}

driver_gene <- args[1]

source("scripts/60_enrichment/framework/00_prepare_transcriptomics.R")
prepare_transcriptomics(driver_gene)


source("scripts/60_enrichment/modules/00_convert_ids.R")
source("scripts/60_enrichment/modules/01_filter_deg.R")
source("scripts/60_enrichment/modules/04_kegg_enrichment.R")
source("scripts/60_enrichment/modules/05_export_kegg.R")

deg <- read.delim(
paste0(
"results/evidence/",
driver_gene,
"/transcriptomics/DEGs.tsv"
),
check.names=FALSE
)

deg <- filter_deg(deg)

mapping <- convert_gene_ids(deg)

kk <- run_kegg(mapping)

export_kegg(
kk,
driver_gene
)

cat("\n=====================================\n")
cat("KEGG enrichment completed\n")
cat("=====================================\n")