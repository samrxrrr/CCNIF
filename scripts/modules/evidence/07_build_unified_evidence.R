library(jsonlite)

build_unified_evidence <- function(driver){

cat("=====================================\n")
cat("CCNIF UNIFIED EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path("results","evidence",driver,"Evidence")

files <- list(
Transcriptomics="Transcriptomics_Evidence.json",
Clinical="Clinical_Evidence.json",
Functional="Functional_Evidence.json",
Network="Network_Evidence.json",
Survival="Survival_Evidence.json",
Enrichment="Enrichment_Evidence.json"
)

evidence <- list(
Metadata=list(
Driver=driver,
Pipeline="CCNIF",
Version="5.0",
Created=as.character(Sys.time())
)
)

for(section in names(files)){

f <- file.path(base,files[[section]])

if(file.exists(f)){

evidence[[section]] <- read_json(
f,
simplifyVector=TRUE
)

}else{

cat("Skipping",section,"\n")

evidence[[section]] <- NULL

}

}

write_json(
evidence,
file.path(base,"Unified_Evidence.json"),
pretty=TRUE,
auto_unbox=TRUE,
null="null"
)

cat("Unified evidence exported.\n")

TRUE

}
