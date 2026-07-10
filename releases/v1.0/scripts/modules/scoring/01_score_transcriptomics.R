library(jsonlite)

score_transcriptomics <- function(driver){

cat("============================================\n")
cat("Transcriptomic Evidence Score\n")
cat("============================================\n")

deg <- read.delim(
"data/transcriptomics/DEGs.tsv",
check.names=FALSE
)

gene <- subset(
deg,
gene_name==driver
)

if(nrow(gene)==0){

stop("Driver not found.")

}

padj <- gene$padj[1]
logfc <- abs(gene$log2FoldChange[1])

score <- 0

if(padj < 0.05) score <- score + 1
if(logfc >= 1) score <- score + 1

result <- list(

driver=driver,

padj=padj,

log2FC=logfc,

score=score,

maximum=2

)

dir.create(
file.path("results","evidence",driver,"Scoring"),
recursive=TRUE,
showWarnings=FALSE
)

write_json(

result,

file.path(
"results",
"evidence",
driver,
"Scoring",
"Transcriptomics.json"
),

pretty=TRUE,
auto_unbox=TRUE

)

cat("Transcriptomic score exported.\n")

}
