load_data <- function(){

message("Loading expression matrix...")

counts <- read.delim(
"data/processed/final/expression_matched.tsv.gz",
check.names=FALSE
)

message("Loading mutation matrix...")

mutation <- read.delim(
"data/processed/final/mutation_matrix_matched.tsv",
row.names=1,
check.names=FALSE
)

message("Loading clinical data...")

clinical <- read.delim(
"data/processed/final/clinical_master_matched.tsv",
check.names=FALSE
)

list(

counts=counts,
mutation=mutation,
clinical=clinical

)

}
