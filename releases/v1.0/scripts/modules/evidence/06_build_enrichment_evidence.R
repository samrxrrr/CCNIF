library(jsonlite)

build_enrichment_evidence <- function(driver){

cat("=====================================\n")
cat("ENRICHMENT EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path("results","evidence",driver)

dir.create(
file.path(base,"Evidence"),
recursive=TRUE,
showWarnings=FALSE
)

go <- file.path(base,"GO","summary.json")
kegg <- file.path(base,"KEGG","summary.json")
reactome <- file.path(base,"Reactome","summary.json")

if(!file.exists(go)) stop("GO summary missing")
if(!file.exists(kegg)) stop("KEGG summary missing")
if(!file.exists(reactome)) stop("Reactome summary missing")

enrichment <- list(

Metadata=list(
Driver=driver,
Domain="Enrichment",
Pipeline="CCNIF",
Version="3.0",
Created=as.character(Sys.time())
),

GO=read_json(go,simplifyVector=TRUE),

KEGG=read_json(kegg,simplifyVector=TRUE),

Reactome=read_json(reactome,simplifyVector=TRUE)

)

write_json(

enrichment,

file.path(
base,
"Evidence",
"Enrichment_Evidence.json"
),

pretty=TRUE,
auto_unbox=TRUE,
null="null"

)

cat("Enrichment evidence exported.\n")

TRUE

}
