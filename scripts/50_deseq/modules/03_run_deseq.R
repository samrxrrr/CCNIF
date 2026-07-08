run_deseq <- function(driver_gene){

source("scripts/50_deseq/modules/00_utils.R")
source("scripts/50_deseq/modules/01_load_data.R")
source("scripts/50_deseq/modules/02_build_design.R")

data <- load_data()

counts <- data$counts
mutation <- data$mutation
clinical <- data$clinical

if(!(driver_gene %in% colnames(mutation))){
    stop(paste("Driver gene not found:", driver_gene))
}

design <- build_design(driver_gene, mutation, clinical)

sample_order <- design$patient_id

counts <- counts[, c("gene_id","gene_name","gene_type", sample_order)]

gene_metadata <- counts[,1:3]

count_matrix <- as.matrix(counts[,4:ncol(counts)])

storage.mode(count_matrix) <- "integer"

rownames(count_matrix) <- gene_metadata$gene_id

rownames(design) <- design$patient_id

dds <- DESeqDataSetFromMatrix(
    countData = count_matrix,
    colData = design,
    design = ~ mutation_status
)

keep <- rowSums(counts(dds) >= 10) >= 10

dds <- dds[keep,]

dds <- DESeq(dds)

res <- results(dds)

res_df <- as.data.frame(res)

res_df$gene_id <- rownames(res_df)

res_df <- merge(
    gene_metadata,
    res_df,
    by="gene_id",
    all.y=TRUE,
    sort=FALSE
)

res_df <- res_df[order(res_df$padj),]

list(
    dds = dds,
    deseq_results = res,
    results = res_df,
    design = design
)

}
