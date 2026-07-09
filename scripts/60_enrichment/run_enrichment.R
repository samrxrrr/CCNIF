args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){
    stop("Usage: Rscript run_enrichment.R TP53")
}

driver <- args[1]

cat("============================================\n")
cat("CCNIF Unified Enrichment Engine\n")
cat("============================================\n")

system(
paste(
"Rscript scripts/60_enrichment/run_go.R",
driver
)
)

system(
paste(
"Rscript scripts/60_enrichment/run_kegg.R",
driver
)
)

system(
paste(
"Rscript scripts/60_enrichment/run_gsea.R",
driver
)
)

system(
paste(
"Rscript scripts/60_enrichment/run_do.R",
driver
)
)

system(
paste(
"Rscript scripts/60_enrichment/run_reactome.R",
driver
)
)

source("scripts/60_enrichment/modules/99_manifest.R")

write_manifest(driver)

cat("\n=====================================\n")
cat("Unified enrichment completed\n")
cat("=====================================\n")
