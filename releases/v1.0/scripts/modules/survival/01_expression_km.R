library(survival)
library(survminer)
library(jsonlite)

run_expression_km <- function(driver_df,driver){

cat("============================================\n")
cat("Expression Kaplan-Meier Analysis\n")
cat("============================================\n")

driver_df$Expression_Group <- ifelse(
driver_df$Expression_Z >= median(driver_df$Expression_Z),
"High",
"Low"
)

fit <- survfit(
Surv(OS_time,OS_event) ~ Expression_Group,
data=driver_df
)

cox <- coxph(
Surv(OS_time,OS_event) ~ Expression_Z,
data=driver_df
)

logrank <- survdiff(
Surv(OS_time,OS_event) ~ Expression_Group,
data=driver_df
)

pvalue <- 1-pchisq(
logrank$chisq,
length(logrank$n)-1
)

outdir <- file.path(
"results",
"evidence",
driver,
"Survival"
)

dir.create(
outdir,
recursive=TRUE,
showWarnings=FALSE
)

png(
file.path(outdir,"Expression_KM.png"),
width=2200,
height=1800,
res=300
)

print(

ggsurvplot(
fit,
data=driver_df,
risk.table=TRUE,
pval=TRUE,
conf.int=FALSE,
palette=c("#2166AC","#B2182B"),
title=paste(driver,"Expression Survival"),
legend.title="Expression",
legend.labs=c("High","Low")
)

)

dev.off()

write.table(

summary(cox)$coefficients,

file.path(outdir,"Expression_Cox.tsv"),

sep="\t",

quote=FALSE

)

write_json(

list(

driver=driver,

logrank_p=pvalue,

events=sum(driver_df$OS_event),

patients=nrow(driver_df)

),

file.path(outdir,"Expression_LogRank.json"),

pretty=TRUE,

auto_unbox=TRUE

)

write.table(

driver_df,

file.path(outdir,"Expression_KM.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

cat("Kaplan-Meier completed.\n")

}
