CCNIF_PATHS <- list(

Transcriptomics="data/transcriptomics",

Evidence="results/evidence",

Registry="results/registry",

Atlas="results/atlas",

Build="results/build",

Logs="results/logs"

)

get_path <- function(name){

if(!name %in% names(CCNIF_PATHS))
stop(paste("Unknown path:",name))

CCNIF_PATHS[[name]]

}
