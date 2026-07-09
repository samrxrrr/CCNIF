library(jsonlite)

extract_statistics <- function(driver){

cat("============================================\n")
cat("Evidence Statistics Extraction\n")
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver
)

stats <- list()

########################################################
# Transcriptomics
########################################################

deg <- read.delim(
file.path(base,"transcriptomics","DEGs.tsv"),
check.names=FALSE
)

stats$Transcriptomics <- list(

Genes=nrow(deg),

MeanLogFC=mean(abs(deg$log2FoldChange),na.rm=TRUE),

MedianLogFC=median(abs(deg$log2FoldChange),na.rm=TRUE),

MaxLogFC=max(abs(deg$log2FoldChange),na.rm=TRUE),

MinPadj=min(deg$padj,na.rm=TRUE),

MedianPadj=median(deg$padj,na.rm=TRUE)

)

########################################################
# GO
########################################################

go <- read.delim(
file.path(base,"GO","GO_BP.tsv"),
check.names=FALSE
)

stats$GO <- list(

Terms=nrow(go),

MedianPadj=median(go$p.adjust),

MinPadj=min(go$p.adjust),

MedianCount=median(go$Count)

)

########################################################
# KEGG
########################################################

kegg <- read.delim(
file.path(base,"KEGG","KEGG.tsv"),
check.names=FALSE
)

stats$KEGG <- list(

Terms=nrow(kegg),

MedianPadj=median(kegg$p.adjust),

MedianCount=median(kegg$Count)

)

########################################################
# Disease Ontology
########################################################

do <- read.delim(
file.path(base,"DiseaseOntology","DiseaseOntology.tsv"),
check.names=FALSE
)

stats$DiseaseOntology <- list(

Terms=nrow(do),

MedianPadj=median(do$p.adjust),

MedianCount=median(do$Count)

)

########################################################
# Reactome
########################################################

reactome <- read.delim(
file.path(base,"Reactome","Reactome.tsv"),
check.names=FALSE
)

stats$Reactome <- list(

Terms=nrow(reactome),

MedianPadj=median(reactome$p.adjust),

MedianCount=median(reactome$Count)

)

########################################################
# STRING
########################################################

network <- read.delim(
file.path(base,"STRING","Network_Metrics.tsv"),
check.names=FALSE
)

stats$STRING <- list(

Nodes=nrow(network),

DegreeSummary=summary(network$Degree),

CompositeSummary=summary(network$CompositeScore)

)

########################################################
# Clinical
########################################################

clinical <- read.delim(
file.path(base,"Clinical","Multivariate_Cox.tsv"),
check.names=FALSE
)

stats$Clinical <- list(

Variables=nrow(clinical),

MedianHR=median(clinical$HR),

MedianP=median(clinical$Pvalue)

)

dir.create(
file.path(base,"Scoring"),
recursive=TRUE,
showWarnings=FALSE
)

write_json(
stats,
file.path(base,"Scoring","Evidence_Statistics.json"),
pretty=TRUE,
auto_unbox=TRUE
)

cat("Evidence statistics exported.\n")

}
