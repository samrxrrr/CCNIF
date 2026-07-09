library(jsonlite)

build_network_evidence <- function(driver){

cat("=====================================\n")
cat("NETWORK EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path("results","evidence",driver)

dir.create(
file.path(base,"Evidence"),
recursive=TRUE,
showWarnings=FALSE
)

summary_file <- file.path(base,"STRING","summary.json")
metrics_file <- file.path(base,"STRING","network_metrics_summary.json")
community_file <- file.path(base,"STRING","community_summary.json")

if(!file.exists(summary_file)) stop("STRING summary missing")
if(!file.exists(metrics_file)) stop("Network metrics missing")
if(!file.exists(community_file)) stop("Community summary missing")

network <- list(

Metadata=list(
Driver=driver,
Domain="Network",
Pipeline="CCNIF",
Version="3.0",
Created=as.character(Sys.time())
),

STRING=read_json(summary_file,simplifyVector=TRUE),
Metrics=read_json(metrics_file,simplifyVector=TRUE),
Communities=read_json(community_file,simplifyVector=TRUE)

)

write_json(

network,

file.path(
base,
"Evidence",
"Network_Evidence.json"
),

pretty=TRUE,
auto_unbox=TRUE,
null="null"

)

cat("Network evidence exported.\n")

TRUE

}
