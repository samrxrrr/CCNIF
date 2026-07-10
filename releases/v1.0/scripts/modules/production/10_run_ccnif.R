source("scripts/modules/automation/10_build_all_drivers.R")
source("scripts/modules/atlas/04_build_atlas.R")
source("scripts/modules/atlas/05_export_atlas.R")
source("scripts/modules/atlas/06_validate_atlas.R")

run_ccnif <- function(){

cat("=====================================\n")
cat("CCNIF MASTER PRODUCTION PIPELINE\n")
cat("=====================================\n\n")

build <- build_all_drivers()

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

list(

Build=build,

Atlas=atlas,

Validation=validation,

Complete=validation$Complete

)

}
