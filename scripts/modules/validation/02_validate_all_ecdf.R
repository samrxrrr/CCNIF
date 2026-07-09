library(jsonlite)

source("scripts/modules/validation/01_ecdf_validation.R")

validate_all_ecdf <- function(driver){

cat("============================================\n")
cat("CCNIF ECDF Validation Engine\n")
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver,
"Statistics"
)

ecdf_dir <- file.path(base,"ECDF")

qc_dir <- file.path(base,"ECDF_QC")

dir.create(
qc_dir,
recursive=TRUE,
showWarnings=FALSE
)

files <- list.files(
ecdf_dir,
pattern="\\.tsv$",
full.names=TRUE
)

master <- list()

for(f in files){

name <- sub("_ECDF.tsv","",basename(f))

cat("Checking:",name,"\n")

rep <- validate_ecdf(f)

master[[name]] <- rep

write_json(

rep,

file.path(
qc_dir,
paste0(name,"_QC.json")
),

pretty=TRUE,

auto_unbox=TRUE

)

}

summary <- list(

Driver=driver,

Files=length(master),

Passed=sum(sapply(master,function(x){

x$MonotonicValue &
x$MonotonicPercentile &
x$BoundaryCheck &
x$Duplicates==0 &
x$MissingValues==0 &
x$MissingPercentiles==0

})),

Failed=sum(!sapply(master,function(x){

x$MonotonicValue &
x$MonotonicPercentile &
x$BoundaryCheck &
x$Duplicates==0 &
x$MissingValues==0 &
x$MissingPercentiles==0

}))

)

write_json(

summary,

file.path(
qc_dir,
"Master_ECDF_Report.json"
),

pretty=TRUE,

auto_unbox=TRUE

)

cat("\nValidation complete.\n")

}
