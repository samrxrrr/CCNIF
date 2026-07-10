library(jsonlite)

source("scripts/modules/automation/01_discover_drivers.R")
source("scripts/modules/automation/02_check_prerequisites.R")
source("scripts/modules/production/08_driver_pipeline.R")

run_driver_scheduler <- function(){

drivers <- discover_drivers()

cat("\n=====================================\n")
cat("CCNIF DRIVER SCHEDULER\n")
cat("=====================================\n\n")

summary <- data.frame(
Driver=character(),
Action=character(),
Passed=integer(),
Failed=integer(),
stringsAsFactors=FALSE
)

for(driver in drivers){

cat("-------------------------------------\n")
cat("Driver :",driver,"\n")
cat("-------------------------------------\n")

status <- check_driver_status(driver)

if(status$Complete){

cat("Status : COMPLETE\n\n")

summary <- rbind(
summary,
data.frame(
Driver=driver,
Action="SKIPPED",
Passed=status$Passed,
Failed=status$Failed,
stringsAsFactors=FALSE
)
)

next

}

cat("Status : BUILDING\n\n")

result <- build_driver(driver)

summary <- rbind(
summary,
data.frame(
Driver=driver,
Action=ifelse(result$Complete,"BUILT","FAILED"),
Passed=result$Passed,
Failed=result$Failed,
stringsAsFactors=FALSE
)
)

}

dir.create("results/build",recursive=TRUE,showWarnings=FALSE)

write.table(
summary,
"results/build/Driver_Scheduler.tsv",
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("\n=====================================\n")
cat("SCHEDULER COMPLETE\n")
cat("=====================================\n")

print(summary)

summary

}
