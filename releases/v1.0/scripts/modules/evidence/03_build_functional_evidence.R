library(jsonlite)

build_functional_evidence <- function(driver){

cat("=====================================\n")
cat("FUNCTIONAL EVIDENCE BUILDER\n")
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

functional <- list(

Metadata=list(
Driver=driver,
Domain="Functional",
Pipeline="CCNIF",
Version="3.0",
Created=as.character(Sys.time())
),

GO=read_json(go,simplifyVector=TRUE),
KEGG=read_json(kegg,simplifyVector=TRUE),
Reactome=read_json(reactome,simplifyVector=TRUE)

)

write_json(

functional,

file.path(
base,
"Evidence",
"Functional_Evidence.json"
),

pretty=TRUE,
auto_unbox=TRUE,
null="null"

)

cat("Functional evidence exported.\n")

TRUE

}
