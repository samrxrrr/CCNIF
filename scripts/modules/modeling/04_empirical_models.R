library(jsonlite)

build_empirical_model <- function(ecdf_file){

d <- read.delim(

ecdf_file,

check.names=FALSE

)

list(

Rows=nrow(d),

Minimum=min(d[[1]]),

Maximum=max(d[[1]]),

UniqueValues=length(unique(d[[1]])),

Duplicates=nrow(d)-length(unique(d[[1]]))

)

}
