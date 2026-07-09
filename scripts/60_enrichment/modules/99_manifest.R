write_manifest <- function(driver){

library(jsonlite)

base <- file.path("results","evidence",driver)

manifest <- list(

driver = driver,

GO = file.exists(file.path(base,"GO","summary.json")),

KEGG = file.exists(file.path(base,"KEGG","summary.json")),

Hallmark = file.exists(file.path(base,"GSEA","summary.json")),

DiseaseOntology = file.exists(file.path(base,"DiseaseOntology","summary.json")),

Reactome = file.exists(file.path(base,"Reactome","summary.json"))

)

write(

toJSON(

manifest,

pretty=TRUE,

auto_unbox=TRUE

),

file.path(

base,

"Enrichment_Manifest.json"

)

)

cat("Manifest written.\n")

}
