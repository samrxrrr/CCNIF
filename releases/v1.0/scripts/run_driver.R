#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript scripts/run_driver.R <DRIVER>")

}

driver <- args[1]

source("scripts/modules/pipeline/06_pipeline_engine.R")

result <- run_pipeline(driver)

if(isTRUE(result$Complete)){

quit(save="no",status=0)

}else{

quit(save="no",status=1)

}
