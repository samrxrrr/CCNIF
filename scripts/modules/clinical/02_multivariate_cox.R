library(survival)
library(jsonlite)

run_multivariate_cox <- function(driver_df, driver){

cat("============================================\n")
cat("Multivariable Cox Regression\n")
cat("============================================\n")

driver_df$TumorStage <- factor(driver_df$tumor_stage)

fit <- coxph(

Surv(OS_time, OS_event) ~

Expression_Z +

Mutation +

age_at_index +

TumorStage,

data = driver_df

)

outdir <- file.path(
"results",
"evidence",
driver,
"Clinical"
)

dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)

coef_table <- summary(fit)$coefficients

ci_table <- summary(fit)$conf.int

results <- data.frame(

Variable = rownames(coef_table),

HR = ci_table[,"exp(coef)"],

Lower95 = ci_table[,"lower .95"],

Upper95 = ci_table[,"upper .95"],

Pvalue = coef_table[,"Pr(>|z|)"],

check.names=FALSE

)

write.table(

results,

file.path(outdir,"Multivariate_Cox.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

write_json(

list(

driver=driver,

patients=nrow(driver_df),

events=sum(driver_df$OS_event),

variables=nrow(results)

),

file.path(outdir,"Clinical_Manifest.json"),

pretty=TRUE,

auto_unbox=TRUE

)

cat("Multivariable Cox completed.\n")

return(results)

}
