args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript run_functional_engine.R TP53")

}

driver <- args[1]

modules <- c(

"02_go_enrichment",

"04_kegg_enrichment",

"07_run_gsea"

)

for(m in modules){

cat("\n=====================================\n")
cat("Running:",m,"\n")
cat("=====================================\n")

source(
paste0(
"scripts/60_enrichment/modules/",
m,
".R"
)
)

}

source(
"scripts/60_enrichment/framework/write_manifest.R"
)

write_manifest(driver)

cat("\n=====================================\n")
cat("Functional Engine Ready\n")
cat("=====================================\n")
