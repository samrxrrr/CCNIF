#!/usr/bin/env Rscript

source("scripts/modules/automation/10_build_all_drivers.R")
source("scripts/modules/atlas/04_build_atlas.R")
source("scripts/modules/atlas/05_export_atlas.R")
source("scripts/modules/atlas/06_validate_atlas.R")

cat("=====================================\n")
cat("CCNIF MASTER PRODUCTION PIPELINE\n")
cat("=====================================\n\n")

build_all_drivers()

cat("\n=====================================\n")
cat("BUILDING PAN-CANCER ATLAS\n")
cat("=====================================\n\n")

atlas <- build_atlas()

export_atlas(atlas)

validation <- validate_atlas()

cat("\n=====================================\n")
cat("ATLAS VALIDATION\n")
cat("=====================================\n")

print(validation)

if(validation$Complete){

cat("\n=====================================\n")
cat("CCNIF PRODUCTION BUILD COMPLETE\n")
cat("=====================================\n")

quit(save="no",status=0)

}else{

cat("\n=====================================\n")
cat("ATLAS BUILD FAILED\n")
cat("=====================================\n")

quit(save="no",status=1)

}
