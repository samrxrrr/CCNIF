read_clinical <- function(){

cat("============================================\n")
cat("Loading Clinical Data\n")
cat("============================================\n")

clinical <- read.delim(
"data/processed/final/clinical_master_matched.tsv",
check.names=FALSE
)

clinical$OS_time <- ifelse(

is.na(clinical$days_to_death),

clinical$days_to_last_follow_up,

clinical$days_to_death

)

clinical$OS_event <- ifelse(

toupper(clinical$vital_status)=="DEAD",

1,

0

)

cat("Patients:",nrow(clinical),"\n")

return(clinical)

}
