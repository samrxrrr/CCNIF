library(jsonlite)

integrate_evidence <- function(driver){

cat("============================================\n")
cat("Integrating Evidence\n")
cat("============================================\n")

base <- file.path(
"results",
"evidence",
driver
)

manifest <- list(

driver = driver,

transcriptomics = file.exists(
file.path(base,"transcriptomics","summary.json")
),

GO = file.exists(
file.path(base,"GO","summary.json")
),

KEGG = file.exists(
file.path(base,"KEGG","summary.json")
),

Hallmark = file.exists(
file.path(base,"GSEA","summary.json")
),

DiseaseOntology = file.exists(
file.path(base,"DiseaseOntology","summary.json")
),

Reactome = file.exists(
file.path(base,"Reactome","summary.json")
),

STRING = file.exists(
file.path(base,"STRING","summary.json")
),

ExpressionSurvival = file.exists(
file.path(base,"Survival","Expression_LogRank.json")
),

MutationSurvival = file.exists(
file.path(base,"Survival","Mutation_LogRank.json")
),

Clinical = file.exists(
file.path(base,"Clinical","Clinical_Manifest.json")
)

)

write_json(

manifest,

file.path(base,"Integrated_Evidence.json"),

pretty=TRUE,

auto_unbox=TRUE

)

cat("Evidence integration complete.\n")

}
