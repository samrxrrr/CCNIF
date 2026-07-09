#!/usr/bin/env Rscript

library(jsonlite)

drivers <- readLines("config/drivers.txt")

cat("=====================================\n")
cat("CCNIF BATCH DRIVER PIPELINE\n")
cat("=====================================\n\n")

success <- 0
failed <- 0

for(driver in drivers){

cat("---------------------------------\n")
cat("Driver :",driver,"\n")

cmd <- paste("Rscript scripts/run_driver.R",driver)

status <- system(cmd)

if(status==0){

cat("SUCCESS\n\n")
success <- success+1

}else{

cat("FAILED\n\n")
failed <- failed+1

}

}

cat("=====================================\n")
cat("Batch Complete\n")
cat("=====================================\n")
cat("Successful :",success,"\n")
cat("Failed     :",failed,"\n")
