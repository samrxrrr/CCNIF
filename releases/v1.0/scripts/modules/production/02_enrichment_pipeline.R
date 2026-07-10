library(jsonlite)

build_enrichment_pipeline <- function(driver){

cat("=====================================\n")
cat("ENRICHMENT PIPELINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

dir.create(
file.path(
"results",
"evidence",
driver,
"Enrichment"
),
recursive=TRUE,
showWarnings=FALSE
)


runs <- list(

GO="scripts/60_enrichment/run_go.R",

KEGG="scripts/60_enrichment/run_kegg.R",

Reactome="scripts/60_enrichment/run_reactome.R",

DiseaseOntology="scripts/60_enrichment/run_do.R",

GSEA="scripts/60_enrichment/run_gsea.R"

)

status <- list()

for(name in names(runs)){

cat("-------------------------------------\n")
cat(name,"\n")
cat("-------------------------------------\n")

ok <- tryCatch({

cmd <- paste(
"Rscript",
runs[[name]],
driver
)

rc <- system(cmd)

rc==0

},

error=function(e){

cat(e$message,"\n")

FALSE

})

status[[name]] <- ok

}

manifest <- list(

Metadata=list(

Driver=driver,

Created=as.character(Sys.time()),

Pipeline="CCNIF"

),

Modules=status,

Passed=sum(unlist(status)),

Failed=sum(!unlist(status))

)

write_json(

manifest,

file.path(

"results",

"evidence",

driver,

"Enrichment",

"Enrichment_Manifest.json"

),

pretty=TRUE,

auto_unbox=TRUE

)

cat("\n=====================================\n")
cat("ENRICHMENT COMPLETE\n")
cat("=====================================\n")

print(manifest)

return(manifest)

}
