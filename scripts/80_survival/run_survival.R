args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1){

stop("Usage: Rscript scripts/80_survival/run_survival.R TP53")

}

driver <- args[1]

source("scripts/80_survival/modules/00_load_clinical.R")
source("scripts/80_survival/modules/01_prepare_survival.R")
source("scripts/80_survival/modules/02_kaplan_meier.R")
source("scripts/80_survival/modules/03_coxph.R")
source("scripts/80_survival/modules/04_export_survival.R")

clinical <- load_clinical()

clinical <- prepare_survival(clinical)

run_km(clinical)

run_cox(clinical)

export_survival(driver,clinical)

cat("\n=====================================\n")
cat("Clinical Survival Framework Ready\n")
cat("=====================================\n")
