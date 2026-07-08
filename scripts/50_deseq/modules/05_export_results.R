export_results <- function(driver_gene,res,design){

outdir <- paste0(
"results/evidence/",
driver_gene,
"/transcriptomics"
)

dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)

res_df <- as.data.frame(res)

res_df$gene_id <- rownames(res_df)

write.table(

res_df,

paste0(outdir,"/DEGs.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

sig <- subset(

res_df,

padj<0.05 &
abs(log2FoldChange)>=1

)

write.table(

sig,

paste0(outdir,"/Significant_DEGs.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

summary <- list(

driver_gene=driver_gene,

mutant=sum(design$mutation_status=="Mutant"),

wildtype=sum(design$mutation_status=="WildType"),

genes_tested=nrow(res_df),

significant=nrow(sig),

upregulated=sum(sig$log2FoldChange>1,na.rm=TRUE),

downregulated=sum(sig$log2FoldChange<(-1),na.rm=TRUE)

)

save_json(

summary,

paste0(outdir,"/summary.json")

)

write.table(

design,

paste0(outdir,"/sample_design.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

writeLines(

capture.output(sessionInfo()),

paste0(outdir,"/sessionInfo.txt")

)

summary

}
