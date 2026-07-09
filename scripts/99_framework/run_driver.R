args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript scripts/99_framework/run_driver.R TP53")

}

driver <- args[1]

source("scripts/99_framework/modules/00_initialize_driver.R")
source("scripts/99_framework/modules/02_validate_project.R")

initialize_driver(driver)

validate_project()

cat("\n=========================================\n")
cat("Framework initialized successfully.\n")
cat("Ready for downstream modules.\n")
cat("=========================================\n")
