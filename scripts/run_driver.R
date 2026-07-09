args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript scripts/run_driver.R TP53")

}

source("scripts/core/driver.R")
source("scripts/core/logger.R")
source("scripts/core/module_manager.R")
source("scripts/core/manifest.R")

driver <- create_driver(args[1])

driver <- log_message(
driver,
paste("Driver created:",driver$metadata$name)
)

write_manifest(driver)

driver <- log_message(
driver,
"Framework initialized successfully."
)

write_manifest(driver)
