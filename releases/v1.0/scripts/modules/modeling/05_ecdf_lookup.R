library(jsonlite)

build_ecdf_lookup <- function(driver,
                              distribution_file,
                              model_name){

cat("============================================\n")
cat(paste(model_name,"ECDF Lookup\n"))
cat("============================================\n")

base <- file.path("results","evidence",driver)

tbl <- read.delim(
file.path(base,"Statistics",distribution_file),
check.names=FALSE
)

outdir <- file.path(base,"Statistics","ECDF")
dir.create(outdir,recursive=TRUE,showWarnings=FALSE)

for(col in names(tbl)){

if(!is.numeric(tbl[[col]]))
next

x <- tbl[[col]]
x <- x[is.finite(x)]

x <- sort(x)

lookup <- data.frame(

Value=x,

Percentile=(seq_along(x)-1)/(length(x)-1)

)

write.table(

lookup,

file=file.path(

outdir,

paste0(model_name,"_",col,"_ECDF.tsv")

),

sep="\t",

quote=FALSE,

row.names=FALSE

)

}

cat(model_name,"lookup exported.\n")

}
