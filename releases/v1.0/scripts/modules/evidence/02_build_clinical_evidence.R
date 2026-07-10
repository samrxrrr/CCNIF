library(jsonlite)

build_clinical_evidence <- function(driver){

cat("=====================================\n")
cat("CLINICAL EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path("results","evidence",driver)

dir.create(
file.path(base,"Evidence"),
recursive=TRUE,
showWarnings=FALSE
)

cox <- file.path(
base,
"Clinical",
"Multivariate_Cox.tsv"
)

manifest <- file.path(
base,
"Clinical",
"Clinical_Manifest.json"
)

if(!file.exists(cox))
stop("Multivariate_Cox.tsv missing")

if(!file.exists(manifest))
stop("Clinical_Manifest.json missing")

cox_data <- read.delim(
cox,
check.names=FALSE
)

clinical <- list(

Metadata=list(
Driver=driver,
Domain="Clinical",
Pipeline="CCNIF",
Version="3.0",
Created=as.character(Sys.time())
),

Summary=list(
Rows=nrow(cox_data),
Columns=ncol(cox_data),
Variables=colnames(cox_data)
)

)

write_json(

clinical,

file.path(
base,
"Evidence",
"Clinical_Evidence.json"
),

pretty=TRUE,
auto_unbox=TRUE,
null="null"

)

cat("Clinical evidence exported.\n")

TRUE

}
