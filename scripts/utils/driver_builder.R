build_driver_dataset <- function(driver,
                                 expression,
                                 mutation,
                                 clinical){

cat("============================================\n")
cat("Building Driver Dataset\n")
cat("============================================\n")

expr <- extract_driver_expression(
expression,
driver
)

expr_df <- data.frame(

patient_id=names(expr),

Expression=as.numeric(expr),

stringsAsFactors=FALSE

)

if(!(driver %in% colnames(mutation))){

stop(
paste(
"Driver not found in mutation matrix:",
driver
)
)

}

mut_df <- mutation[,c("patient_id",driver)]

colnames(mut_df)[2] <- "Mutation"

merged <- merge(

clinical,

expr_df,

by="patient_id"

)

merged <- merge(

merged,

mut_df,

by="patient_id"

)

cat("Patients:",nrow(merged),"\n")

return(merged)

}
