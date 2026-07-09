library(jsonlite)

source("scripts/modules/atlas/02_load_driver_reports.R")

merge_driver_reports <- function(drivers){

atlas <- list()

for(driver in drivers){

report_file <- file.path(
"results",
"evidence",
driver,
"Driver_Report.json"
)

if(!file.exists(report_file)){

cat("Skipping",driver,"(Driver_Report.json missing)\n")

next

}

atlas[[driver]] <- load_driver_report(driver)

}

atlas

}
