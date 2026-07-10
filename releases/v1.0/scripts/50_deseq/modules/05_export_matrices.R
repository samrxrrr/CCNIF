export_matrices <- function(dds, driver_gene){

library(DESeq2)

outdir <- file.path(
    "results",
    "evidence",
    driver_gene,
    "transcriptomics"
)

dir.create(
    outdir,
    recursive = TRUE,
    showWarnings = FALSE
)

cat("============================================\n")
cat("Exporting normalized counts\n")
cat("============================================\n")

norm <- counts(
    dds,
    normalized = TRUE
)

write.table(
    norm,
    gzfile(file.path(outdir,"Normalized_Counts.tsv.gz")),
    sep="\t",
    quote=FALSE
)

cat("Normalized counts exported.\n")

cat("============================================\n")
cat("Computing VST matrix\n")
cat("============================================\n")

vsd <- vst(
    dds,
    blind = FALSE
)

vst_matrix <- assay(vsd)

write.table(
    vst_matrix,
    gzfile(file.path(outdir,"VST.tsv.gz")),
    sep="\t",
    quote=FALSE
)

saveRDS(
    vsd,
    file.path(outdir,"VST.rds")
)

cat("VST exported.\n")

return(vsd)

}
