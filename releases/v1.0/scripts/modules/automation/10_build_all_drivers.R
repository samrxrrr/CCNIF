library(jsonlite)

source("scripts/modules/automation/01_discover_drivers.R")
source("scripts/modules/automation/02_check_prerequisites.R")
source("scripts/modules/production/08_driver_pipeline.R")

build_all_drivers <- function(){

drivers <- discover_drivers()

cat("\n=====================================\n")
cat("CCNIF AUTOMATIC BUILD SYSTEM\n")
cat("=====================================\n\n")

summary <- data.frame(

Driver=character(),
Status=character(),
Passed=integer(),
Failed=integer(),
stringsAsFactors=FALSE

)

for(driver in drivers){

cat("\n-------------------------------------\n")
cat("Driver:",driver,"\n")
cat("-------------------------------------\n")

status <- check_driver_status(driver)

if(status$Complete){

cat("Already complete. Skipping rebuild.\n")

summary <- rbind(

summary,

data.frame(

Driver=driver,
Status="SKIPPED",
Passed=status$Passed,
Failed=status$Failed,
stringsAsFactors=FALSE

)

)

next

}

cat("Building missing components...\n")

result <- build_driver(driver)

summary <- rbind(

summary,

data.frame(

Driver=driver,
Status=ifelse(result$Complete,"BUILT","FAILED"),
Passed=result$Passed,
Failed=result$Failed,
stringsAsFactors=FALSE

)

)

}

cat("\n=====================================\n")
cat("BUILD SUMMARY\n")
cat("=====================================\n")

print(summary)

dir.create("results/build",recursive=TRUE,showWarnings=FALSE)

write.table(

summary,

"results/build/Driver_Build_Summary.tsv",

sep="\t",
row.names=FALSE,
quote=FALSE

)

summary

}
