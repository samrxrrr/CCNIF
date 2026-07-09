build_enrichment_distribution <- function(driver,
                                          source_folder,
                                          input_file,
                                          output_name){

cat("============================================\n")
cat(paste("Building",output_name,"\n"))
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver
)

tbl <- read.delim(
file.path(base,source_folder,input_file),
check.names=FALSE
)

if("p.adjust" %in% colnames(tbl)){

tbl <- tbl[order(tbl$p.adjust),]

}else if("FDR" %in% colnames(tbl)){

tbl <- tbl[order(tbl$FDR),]

}

tbl$Rank <- seq_len(nrow(tbl))

tbl$Percentile <- round(
(tbl$Rank-1)/(nrow(tbl)-1),
6
)

dir.create(
file.path(base,"Statistics"),
recursive=TRUE,
showWarnings=FALSE
)

write.table(
tbl,
file.path(
base,
"Statistics",
paste0(output_name,"_Distribution.tsv")
),
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("Rows :",nrow(tbl),"\n")
cat("Finished.\n\n")

}
