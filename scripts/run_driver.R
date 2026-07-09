#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript scripts/run_driver.R <DRIVER>")

}

driver <- args[1]

cat("=====================================\n")
cat("CCNIF DRIVER PIPELINE\n")
cat("=====================================\n")
cat("Driver :",driver,"\n\n")

source("scripts/modules/reporting/01_master_report.R")
source("scripts/modules/reporting/02_build_report.R")
source("scripts/modules/reporting/03_export_report.R")
source("scripts/modules/reporting/04_driver_manifest.R")
source("scripts/modules/reporting/05_export_manifest.R")
source("scripts/modules/reporting/06_validate_driver_report.R")

cat("Building report...\n")

report <- build_driver_report(driver)

export_driver_report(

report,
driver

)

cat("Building manifest...\n")

manifest <- build_driver_manifest(driver)

export_driver_manifest(

manifest,
driver

)

cat("Validating...\n")

validation <- validate_driver_report(driver)

print(validation)

if(validation$Complete){

cat("\nPIPELINE SUCCESS\n")

}else{

cat("\nPIPELINE FAILED\n")

}

