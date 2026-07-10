library(jsonlite)

write_manifest <- function(driver){

root <- file.path(
"results",
"evidence",
driver
)

manifest <- list(

driver=driver,

transcriptomics=file.exists(
file.path(root,"transcriptomics","summary.json")
),

go=file.exists(
file.path(root,"GO","summary.json")
),

kegg=file.exists(
file.path(root,"KEGG","summary.json")
),

hallmark=file.exists(
file.path(root,"GSEA","summary.json")
),

reactome=file.exists(
file.path(root,"Reactome","summary.json")
),

disease_ontology=file.exists(
file.path(root,"DiseaseOntology","summary.json")
),

network=file.exists(
file.path(root,"Network","summary.json")
),

clinical=file.exists(
file.path(root,"Clinical","summary.json")
)

)

write(

toJSON(
manifest,
pretty=TRUE,
auto_unbox=TRUE
),

file.path(
root,
"manifest.json"
)

)

cat("Manifest updated.\n")

}
