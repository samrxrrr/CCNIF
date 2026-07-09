library(jsonlite)

build_survival_evidence <- function(driver){

cat("=====================================\n")
cat("SURVIVAL EVIDENCE BUILDER\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

base <- file.path("results","evidence",driver)

dir.create(
file.path(base,"Evidence"),
recursive=TRUE,
showWarnings=FALSE
)

expr <- file.path(base,"Survival","Expression_LogRank.json")
mut  <- file.path(base,"Survival","Mutation_LogRank.json")
cox1 <- file.path(base,"Survival","Expression_Cox.tsv")
cox2 <- file.path(base,"Survival","Mutation_Cox.tsv")

if(!file.exists(expr)) stop("Expression_LogRank.json missing")
if(!file.exists(mut)) stop("Mutation_LogRank.json missing")
if(!file.exists(cox1)) stop("Expression_Cox.tsv missing")
if(!file.exists(cox2)) stop("Mutation_Cox.tsv missing")

survival <- list(

Metadata=list(
Driver=driver,
Domain="Survival",
Pipeline="CCNIF",
Version="3.0",
Created=as.character(Sys.time())
),

Expression=read_json(expr,simplifyVector=TRUE),

Mutation=read_json(mut,simplifyVector=TRUE),

ExpressionCox=list(
Rows=nrow(read.delim(cox1,check.names=FALSE))
),

MutationCox=list(
Rows=nrow(read.delim(cox2,check.names=FALSE))
)

)

write_json(

survival,

file.path(
base,
"Evidence",
"Survival_Evidence.json"
),

pretty=TRUE,
auto_unbox=TRUE,
null="null"

)

cat("Survival evidence exported.\n")

TRUE

}
