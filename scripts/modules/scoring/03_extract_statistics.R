library(jsonlite)

extract_statistics <- function(driver){

cat("============================================\n")
cat("Evidence Statistics Extraction\n")
cat("============================================\n")

base <- file.path("results","evidence",driver)

stats <- list()

####################################################
# Transcriptomics
####################################################

deg <- read.delim(
file.path(base,"transcriptomics","DEGs.tsv"),
check.names=FALSE
)

stats$Transcriptomics <- list(
Genes=nrow(deg),
MeanLogFC=mean(abs(deg$log2FoldChange),na.rm=TRUE),
MedianLogFC=median(abs(deg$log2FoldChange),na.rm=TRUE),
SDLogFC=sd(abs(deg$log2FoldChange),na.rm=TRUE),
MaxLogFC=max(abs(deg$log2FoldChange),na.rm=TRUE),
MinPadj=min(deg$padj,na.rm=TRUE),
MedianPadj=median(deg$padj,na.rm=TRUE)
)

####################################################
# GO
####################################################

go <- read.delim(
file.path(base,"GO","GO_BP.tsv"),
check.names=FALSE
)

stats$GO <- list(
Terms=nrow(go),
MedianPadj=median(go$p.adjust,na.rm=TRUE),
MinPadj=min(go$p.adjust,na.rm=TRUE),
MedianCount=median(go$Count,na.rm=TRUE)
)

####################################################
# KEGG
####################################################

kegg <- read.delim(
file.path(base,"KEGG","KEGG.tsv"),
check.names=FALSE
)

stats$KEGG <- list(
Terms=nrow(kegg),
MedianPadj=median(kegg$p.adjust,na.rm=TRUE),
MinPadj=min(kegg$p.adjust,na.rm=TRUE),
MedianCount=median(kegg$Count,na.rm=TRUE)
)

####################################################
# Disease Ontology
####################################################

do <- read.delim(
file.path(base,"DiseaseOntology","DiseaseOntology.tsv"),
check.names=FALSE
)

stats$DiseaseOntology <- list(
Terms=nrow(do),
MedianPadj=median(do$p.adjust,na.rm=TRUE),
MinPadj=min(do$p.adjust,na.rm=TRUE),
MedianCount=median(do$Count,na.rm=TRUE)
)

####################################################
# Reactome
####################################################

reactome <- read.delim(
file.path(base,"Reactome","Reactome.tsv"),
check.names=FALSE
)

stats$Reactome <- list(
Terms=nrow(reactome),
MedianPadj=median(reactome$p.adjust,na.rm=TRUE),
MinPadj=min(reactome$p.adjust,na.rm=TRUE),
MedianCount=median(reactome$Count,na.rm=TRUE)
)

####################################################
# STRING
####################################################

network <- read.delim(
file.path(base,"STRING","Network_Metrics.tsv"),
check.names=FALSE
)

stats$STRING <- list(

Nodes=nrow(network),

Degree=list(
Min=min(network$Degree,na.rm=TRUE),
Q1=unname(quantile(network$Degree,0.25,na.rm=TRUE)),
Median=median(network$Degree,na.rm=TRUE),
Mean=mean(network$Degree,na.rm=TRUE),
Q3=unname(quantile(network$Degree,0.75,na.rm=TRUE)),
Max=max(network$Degree,na.rm=TRUE)
),

Composite=list(
Min=min(network$CompositeScore,na.rm=TRUE),
Q1=unname(quantile(network$CompositeScore,0.25,na.rm=TRUE)),
Median=median(network$CompositeScore,na.rm=TRUE),
Mean=mean(network$CompositeScore,na.rm=TRUE),
Q3=unname(quantile(network$CompositeScore,0.75,na.rm=TRUE)),
Max=max(network$CompositeScore,na.rm=TRUE)
)

)

####################################################
# Clinical
####################################################

clinical <- read.delim(
file.path(base,"Clinical","Multivariate_Cox.tsv"),
check.names=FALSE
)

stats$Clinical <- list(
Variables=nrow(clinical),
MedianHR=median(clinical$HR,na.rm=TRUE),
MedianP=median(clinical$Pvalue,na.rm=TRUE)
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
