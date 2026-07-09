library(jsonlite)

source("scripts/modules/atlas/01_collect_drivers.R")
source("scripts/modules/atlas/03_merge_driver_reports.R")

build_atlas <- function(){

drivers <- collect_drivers()

reports <- merge_driver_reports(drivers)

atlas <- list(

Metadata=list(

Version="1.0",
Pipeline="CCNIF",
Created=as.character(Sys.time()),
DriversLoaded=length(reports)

),

Drivers=names(reports),

Reports=reports

)

atlas

}
