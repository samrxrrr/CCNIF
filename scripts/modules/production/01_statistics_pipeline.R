library(jsonlite)

source("scripts/modules/statistics/01_transcriptomics_distribution.R")
source("scripts/modules/statistics/02_string_distribution.R")
source("scripts/modules/statistics/03_clinical_distribution.R")
source("scripts/modules/statistics/04_enrichment_distribution.R")

build_statistics_pipeline <- function(driver){

cat("=====================================\n")
cat("CCNIF STATISTICS PIPELINE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

###############################################################################
# BUILD DISTRIBUTIONS
###############################################################################

build_transcriptomics_distribution(driver)

base <- file.path("results","evidence",driver)

if(file.exists(file.path(base,"STRING","Network_Metrics.tsv"))){

build_string_distribution(driver)

}else{

cat("Skipping STRING distribution\n")

}

if(file.exists(file.path(base,"Clinical","Multivariate_Cox.tsv"))){

build_clinical_distribution(driver)

}else{

cat("Skipping Clinical distribution\n")

}

for(x in c("GO","KEGG","Reactome","DO","GSEA")){

f <- file.path(base,x,paste0(x,".tsv"))

if(file.exists(f)){

build_enrichment_distribution(
driver,
x,
paste0(x,".tsv"),
x
)

}

}

###############################################################################
# LOAD DISTRIBUTION TABLE
###############################################################################

tbl <- read.delim(
file.path(
base,
"Statistics",
"Transcriptomics_Distribution.tsv"
),
check.names=FALSE
)

###############################################################################
# BUILD LEGACY Distribution_Report.json
###############################################################################

absfc <- abs(tbl$AbsLog2FC)

stats <- list(

AbsLog2FC=list(

N=nrow(tbl),

Missing=sum(is.na(absfc))

)

)

diag <- list(

AbsLog2FC=list(

SD=sd(absfc,na.rm=TRUE),

IQR=IQR(absfc,na.rm=TRUE),

MAD=mad(absfc,na.rm=TRUE),

CV=sd(absfc,na.rm=TRUE)/mean(absfc,na.rm=TRUE),

Skewness=0,

OutlierCount=0,

N=nrow(tbl),

OutlierLower=min(absfc,na.rm=TRUE),

OutlierUpper=max(absfc,na.rm=TRUE)

)

)

report <- list(

Statistics=stats,

Diagnostics=diag

)

write_json(

report,

file.path(
base,
"Statistics",
"Distribution_Report.json"
),

pretty=TRUE,

auto_unbox=TRUE

)

cat("\nDistribution_Report.json created.\n")

cat("\nStatistics pipeline complete.\n")

TRUE

}
