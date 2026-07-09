library(data.table)

extract_driver_record <- function(driver){

deg_file <- file.path(
"results",
"evidence",
driver,
"transcriptomics",
"DEGs.tsv"
)

if(!file.exists(deg_file))
stop(paste("Missing:",deg_file))

deg <- fread(deg_file)

required <- c(
"gene_name",
"log2FoldChange",
"baseMean",
"padj"
)

missing <- setdiff(required,names(deg))

if(length(missing)>0){

stop(
paste(
"Missing columns:",
paste(missing,collapse=", ")
)
)

}

row <- deg[gene_name==driver]

if(nrow(row)!=1){

stop(
paste(
"Driver",
driver,
"not found in DEGs.tsv"
)
)

}

rank <- rank(
-abs(deg$log2FoldChange),
ties.method="min"
)

driver_index <- which(deg$gene_name==driver)

percentile <- 100*(1-(rank[driver_index]-1)/(nrow(deg)-1))

list(

Driver=driver,

GeneID=row$gene_id,

GeneName=row$gene_name,

Observed=abs(row$log2FoldChange),

log2FC=row$log2FoldChange,

AbsLog2FC=abs(row$log2FoldChange),

baseMean=row$baseMean,

padj=row$padj,

Rank=rank[driver_index],

Percentile=round(percentile,4)

)

}
