library(jsonlite)

source("scripts/modules/reliability/11_reliability_score.R")

build_reliability_pipeline <- function(driver){

cat("=====================================\n")
cat("RELIABILITY PIPELINE\n")
cat("=====================================\n")

x <- calculate_reliability_score(driver)

report <- list(

Metadata=list(

Version="2.0",
Pipeline="CCNIF",
Driver=driver,
Created=as.character(Sys.time())

),

ReliabilityScore=x$ReliabilityScore,

Modules=x$Modules,

Scores=x$Scores,

Interpretation=if(x$ReliabilityScore>=90){

"Excellent"

}else if(x$ReliabilityScore>=75){

"Good"

}else{

"Needs Improvement"

}

)

write_json(

report,

file.path(
"results",
"evidence",
driver,
"Statistics",
"Reliability_Report.json"
),

pretty=TRUE,
auto_unbox=TRUE

)

cat("Reliability exported.\n")

report

}
