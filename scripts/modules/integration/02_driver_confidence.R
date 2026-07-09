library(jsonlite)

build_driver_confidence <- function(driver){

cat("============================================\n")
cat("Building Driver Confidence Framework\n")
cat("============================================\n")

base <- file.path("results","evidence",driver)

evidence <- data.frame(

Category=c(
"Transcriptomics",
"GO",
"KEGG",
"Hallmark",
"DiseaseOntology",
"Reactome",
"STRING",
"ExpressionSurvival",
"MutationSurvival",
"Clinical"
),

Available=c(
file.exists(file.path(base,"transcriptomics","summary.json")),
file.exists(file.path(base,"GO","summary.json")),
file.exists(file.path(base,"KEGG","summary.json")),
file.exists(file.path(base,"GSEA","summary.json")),
file.exists(file.path(base,"DiseaseOntology","summary.json")),
file.exists(file.path(base,"Reactome","summary.json")),
file.exists(file.path(base,"STRING","summary.json")),
file.exists(file.path(base,"Survival","Expression_LogRank.json")),
file.exists(file.path(base,"Survival","Mutation_LogRank.json")),
file.exists(file.path(base,"Clinical","Clinical_Manifest.json"))
),

stringsAsFactors=FALSE

)

evidence$Weight <- ifelse(evidence$Available,1,0)

score <- sum(evidence$Weight)

confidence <- dplyr::case_when(
score >= 9 ~ "Very High",
score >= 7 ~ "High",
score >= 5 ~ "Moderate",
TRUE ~ "Low"
)

write.table(
evidence,
file.path(base,"Driver_Confidence_Table.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

write_json(
list(
driver=driver,
score=score,
maximum=10,
confidence=confidence
),
file.path(base,"Driver_Confidence.json"),
pretty=TRUE,
auto_unbox=TRUE
)

cat("Driver Confidence Framework completed.\n")

}
