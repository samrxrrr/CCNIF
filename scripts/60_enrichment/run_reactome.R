args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){
    stop("Usage: Rscript run_reactome.R TP53")
}

driver <- args[1]

source("scripts/60_enrichment/modules/01_filter_deg.R")
source("scripts/60_enrichment/modules/00_convert_ids.R")
source("scripts/60_enrichment/modules/11_run_reactome.R")
source("scripts/60_enrichment/modules/12_export_reactome.R")

deg <- read.delim(
    file.path(
        "results",
        "evidence",
        driver,
        "transcriptomics",
        "DEGs.tsv"
    ),
    check.names = FALSE
)

deg <- filter_deg(deg)

map <- convert_gene_ids(deg)

reactome <- run_reactome(map)

export_reactome(driver, reactome)

cat("\n=====================================\n")
cat("Reactome enrichment completed\n")
cat("=====================================\n")
