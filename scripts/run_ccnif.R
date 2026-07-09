#!/usr/bin/env Rscript

source("scripts/modules/production/10_run_ccnif.R")

result <- run_ccnif()

if(result$Complete){

cat("\n=====================================\n")
cat("CCNIF PRODUCTION BUILD COMPLETE\n")
cat("=====================================\n")

quit(save="no",status=0)

}else{

cat("\n=====================================\n")
cat("CCNIF PRODUCTION BUILD FAILED\n")
cat("=====================================\n")

quit(save="no",status=1)

}
