library(jsonlite)

build_weighted_evidence <- function(driver){

cat("============================================\n")
cat("Weighted Evidence Engine\n")
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver,
"Scoring"
)

ev <- fromJSON(
file.path(base,"Evidence_Normalized.json")
)

domain <- data.frame(

Domain=c(
"Transcriptomics",
"Functional",
"Network",
"Clinical"
),

Score=c(

mean(c(
ev$Transcriptomics$padj,
ev$Transcriptomics$log2FC
)),

mean(c(
ev$GO$best,
ev$GO$terms,
ev$KEGG$best,
ev$KEGG$terms,
ev$DiseaseOntology$best,
ev$DiseaseOntology$terms,
ev$Reactome$best,
ev$Reactome$terms
)),

mean(c(
ev$STRING$Degree,
ev$STRING$Composite
)),

mean(c(
ev$Clinical$Expression_p,
ev$Clinical$Mutation_p,
ev$Clinical$Expression_HR,
ev$Clinical$Mutation_HR
))

),

Weight=c(
1.50,
1.30,
1.20,
1.50
),

stringsAsFactors=FALSE

)

domain$Contribution <- round(
domain$Score * domain$Weight,
4
)

overall <- sum(domain$Contribution) /
sum(domain$Weight)

tier <- if(overall >= 0.85){

"Very High"

}else if(overall >= 0.70){

"High"

}else if(overall >= 0.50){

"Moderate"

}else{

"Low"

}

write.table(

domain,

file.path(
base,
"Evidence_Quality.tsv"
),

sep="\t",

quote=FALSE,

row.names=FALSE

)

write_json(

list(

driver=driver,

overall_score=round(overall,4),

tier=tier,

weights=as.list(domain$Weight)

),

file.path(
base,
"Evidence_Quality.json"
),

pretty=TRUE,

auto_unbox=TRUE

)

cat("Weighted evidence completed.\n")

}
