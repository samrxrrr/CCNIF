library(jsonlite)

collect_evidence <- function(driver){

cat("============================================\n")
cat("CCNIF Evidence Collector\n")
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver
)

evidence <- list()

####################################################
## Transcriptomics
####################################################

deg <- read.delim(
file.path(base,"transcriptomics","DEGs.tsv"),
check.names=FALSE
)

gene <- subset(
deg,
gene_name==driver
)

evidence$Transcriptomics <- list(

padj=gene$padj[1],

log2FC=gene$log2FoldChange[1]

)

####################################################
## GO
####################################################

go <- read.delim(
file.path(base,"GO","GO_BP.tsv"),
check.names=FALSE
)

evidence$GO <- list(

terms=nrow(go),

best=min(go$p.adjust)

)

####################################################
## KEGG
####################################################

kegg <- read.delim(
file.path(base,"KEGG","KEGG.tsv"),
check.names=FALSE
)

evidence$KEGG <- list(

terms=nrow(kegg),

best=min(kegg$p.adjust)

)

####################################################
## Disease Ontology
####################################################

do <- read.delim(
file.path(base,"DiseaseOntology","DiseaseOntology.tsv"),
check.names=FALSE
)

evidence$DiseaseOntology <- list(

terms=nrow(do),

best=min(do$p.adjust)

)

####################################################
## Reactome
####################################################

reactome <- read.delim(
file.path(base,"Reactome","Reactome.tsv"),
check.names=FALSE
)

evidence$Reactome <- list(

terms=nrow(reactome),

best=min(reactome$p.adjust)

)

####################################################
## STRING
####################################################

network <- read.delim(
file.path(base,"STRING","Network_Metrics.tsv"),
check.names=FALSE
)

hub <- subset(
network,
Gene==driver
)

if(nrow(hub)==0){

hub <- network[1,]

}

evidence$STRING <- list(

Degree=hub$Degree[1],

Composite=hub$CompositeScore[1]

)

####################################################
## Survival
####################################################

expr <- fromJSON(
file.path(base,"Survival","Expression_LogRank.json")
)

mut <- fromJSON(
file.path(base,"Survival","Mutation_LogRank.json")
)

cox <- read.delim(
file.path(base,"Clinical","Multivariate_Cox.tsv"),
check.names=FALSE
)

expr_row <- subset(
cox,
Variable=="Expression_Z"
)

mut_row <- subset(
cox,
Variable=="Mutation"
)

evidence$Clinical <- list(

Expression_p=expr$logrank_p,

Mutation_p=mut$logrank_p,

Expression_HR=expr_row$HR,

Mutation_HR=mut_row$HR

)

dir.create(
file.path(base,"Scoring"),
recursive=TRUE,
showWarnings=FALSE
)

write_json(

evidence,

file.path(
base,
"Scoring",
"Evidence_Collected.json"
),

pretty=TRUE,
auto_unbox=TRUE

)

cat("Evidence collection complete.\n")

}
