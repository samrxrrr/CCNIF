library(jsonlite)

normalize01 <- function(x,minv,maxv){

if(is.na(x)) return(0)

if(maxv==minv) return(0)

y <- (x-minv)/(maxv-minv)

y <- max(0,min(1,y))

return(round(y,4))

}

normalize_p <- function(p){

if(is.na(p)) return(0)

if(p<=0) p <- 1e-300

score <- -log10(p)/10

score <- max(0,min(1,score))

return(round(score,4))

}

normalize_hr <- function(hr){

if(is.na(hr)) return(0)

score <- 1/(1+abs(log(hr)))

return(round(score,4))

}

normalize_evidence <- function(driver){

cat("============================================\n")
cat("Evidence Normalization Engine\n")
cat("============================================\n")

base <- file.path("results","evidence",driver,"Scoring")

ev <- fromJSON(
file.path(base,"Evidence_Collected.json")
)

norm <- list()

##################################################
## Transcriptomics
##################################################

norm$Transcriptomics <- list(

padj=normalize_p(ev$Transcriptomics$padj),

log2FC=normalize01(
abs(ev$Transcriptomics$log2FC),
0,
4
)

)

##################################################
## GO
##################################################

norm$GO <- list(

best=normalize_p(ev$GO$best),

terms=normalize01(ev$GO$terms,0,200)

)

##################################################
## KEGG
##################################################

norm$KEGG <- list(

best=normalize_p(ev$KEGG$best),

terms=normalize01(ev$KEGG$terms,0,100)

)

##################################################
## Disease Ontology
##################################################

norm$DiseaseOntology <- list(

best=normalize_p(ev$DiseaseOntology$best),

terms=normalize01(ev$DiseaseOntology$terms,0,100)

)

##################################################
## Reactome
##################################################

norm$Reactome <- list(

best=normalize_p(ev$Reactome$best),

terms=normalize01(ev$Reactome$terms,0,100)

)

##################################################
## STRING
##################################################

norm$STRING <- list(

Degree=normalize01(
ev$STRING$Degree,
0,
200
),

Composite=normalize01(
ev$STRING$Composite,
0,
100
)

)

##################################################
## Clinical
##################################################

norm$Clinical <- list(

Expression_p=normalize_p(
ev$Clinical$Expression_p
),

Mutation_p=normalize_p(
ev$Clinical$Mutation_p
),

Expression_HR=normalize_hr(
ev$Clinical$Expression_HR
),

Mutation_HR=normalize_hr(
ev$Clinical$Mutation_HR
)

)

write_json(
norm,
file.path(base,"Evidence_Normalized.json"),
pretty=TRUE,
auto_unbox=TRUE
)

cat("Evidence normalization completed.\n")

}
