library(jsonlite)

qc_distribution <- function(driver,
                            distribution_file,
                            qc_name){

cat("============================================\n")
cat(paste(qc_name,"QC\n"))
cat("============================================\n")

base <- file.path("results","evidence",driver)

tbl <- read.delim(
file.path(base,"Statistics",distribution_file),
check.names=FALSE
)

qc <- list()

qc$Rows <- nrow(tbl)
qc$Columns <- ncol(tbl)

qc$DuplicateRows <- sum(duplicated(tbl))

qc$MissingValues <- sum(is.na(tbl))

qc$InfiniteValues <- sum(sapply(tbl,function(x){
if(is.numeric(x)) sum(is.infinite(x)) else 0
}))

qc$NumericColumns <- names(tbl)[sapply(tbl,is.numeric)]

qc$ConstantColumns <- names(tbl)[sapply(tbl,function(x){
is.numeric(x) && length(unique(x))==1
})]

dir.create(
file.path(base,"Statistics","QC"),
recursive=TRUE,
showWarnings=FALSE
)

write_json(
qc,
file.path(
base,
"Statistics",
"QC",
paste0(qc_name,"_QC.json")
),
pretty=TRUE,
auto_unbox=TRUE
)

cat(qc_name,"QC exported.\n")

}
