initialize_driver <- function(driver){

cat("=====================================================\n")
cat("CCNIF DRIVER PIPELINE\n")
cat("=====================================================\n")
cat("Driver :",driver,"\n")
cat("Started:",Sys.time(),"\n\n")

dir.create(
file.path("results","evidence",driver),
recursive=TRUE,
showWarnings=FALSE
)

dirs <- c(
"transcriptomics",
"GO",
"KEGG",
"GSEA",
"DiseaseOntology",
"Reactome",
"STRING",
"Survival",
"Integration",
"Reports"
)

for(d in dirs){

dir.create(
file.path(
"results",
"evidence",
driver,
d
),
recursive=TRUE,
showWarnings=FALSE
)

}

}
