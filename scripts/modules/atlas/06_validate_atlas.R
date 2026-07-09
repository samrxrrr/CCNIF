library(jsonlite)

validate_atlas <- function(){

atlas_file <- "results/atlas/CCNIF_Atlas.json"

if(!file.exists(atlas_file))
stop("Atlas not found.")

atlas <- read_json(
atlas_file,
simplifyVector=TRUE
)

checks <- list(

AtlasExists=file.exists(atlas_file),

DriverCount=length(atlas$Drivers),

ReportsLoaded=length(atlas$Reports),

Metadata=!is.null(atlas$Metadata),

Pipeline=(atlas$Metadata$Pipeline=="CCNIF")

)

list(

Passed=sum(unlist(checks)),

Failed=length(checks)-sum(unlist(checks)),

Complete=all(unlist(checks)),

Checks=checks

)

}
