prepare_survival <- function(clinical){

cat("============================================\n")
cat("Preparing Survival Dataset\n")
cat("============================================\n")

id_candidates <- c(
"patient_id",
"submitter_id",
"case_submitter_id"
)

status_candidates <- c(
"vital_status"
)

death_candidates <- c(
"days_to_death"
)

followup_candidates <- c(
"days_to_last_follow_up",
"days_to_last_followup"
)

id_col <- id_candidates[id_candidates %in% colnames(clinical)][1]
status_col <- status_candidates[status_candidates %in% colnames(clinical)][1]
death_col <- death_candidates[death_candidates %in% colnames(clinical)][1]
follow_col <- followup_candidates[followup_candidates %in% colnames(clinical)][1]

required <- c(id_col,status_col,death_col,follow_col)

if(any(is.na(required))){

cat("Detected columns:\n")
print(required)

stop("Unable to identify survival columns.")

}

clinical$OS_time <- ifelse(
is.na(clinical[[death_col]]),
clinical[[follow_col]],
clinical[[death_col]]
)

clinical$OS_event <- ifelse(
toupper(clinical[[status_col]])=="DEAD",
1,
0
)

cat("Patient ID column :",id_col,"\n")
cat("Status column     :",status_col,"\n")
cat("Death column      :",death_col,"\n")
cat("Follow-up column  :",follow_col,"\n")

cat("Events :",sum(clinical$OS_event),"\n")
cat("Censored :",sum(clinical$OS_event==0),"\n")

return(clinical)

}
