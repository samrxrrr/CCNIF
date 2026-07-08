make_plots <- function(driver_gene, deseq_results){

dir.create(
paste0("figures/evidence/",driver_gene),
recursive=TRUE,
showWarnings=FALSE
)

png(
paste0(
"figures/evidence/",
driver_gene,
"/MAplot.png"
),
width=1800,
height=1400,
res=220
)

DESeq2::plotMA(deseq_results)

dev.off()

EnhancedVolcano(

as.data.frame(deseq_results),

lab=rownames(deseq_results),

x="log2FoldChange",

y="padj",

title=driver_gene

)

ggsave(

paste0(
"figures/evidence/",
driver_gene,
"/Volcano.png"
),

width=8,

height=7

)

}
