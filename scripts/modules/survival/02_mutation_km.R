library(survival)
library(survminer)
library(jsonlite)

run_mutation_km <- function(driver_df, driver){

cat("============================================\n")
cat("Mutation Kaplan-Meier Analysis\n")
cat("============================================\n")

driver_df$Mutation_Group <- ifelse(
driver_df$Mutation==1,
"Mutant",
"Wildtype"
)

cat("Mutation counts:\n")
print(table(driver_df$Mutation_Group))

fit <- survfit(
Surv(OS_time,OS_event) ~ Mutation_Group,
data=driver_df
)

cox <- coxph(
Surv(OS_time,OS_event) ~ Mutation,
data=driver_df
)

logrank <- survdiff(
Surv(OS_time,OS_event) ~ Mutation_Group,
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

p <- ggsurvplot(
fit,
data=driver_df,
risk.table=TRUE,
pval=TRUE,
conf.int=FALSE,
title=paste(driver,"Mutation Survival"),
legend.title="Mutation",
legend.labs=c("Mutant","Wildtype")
)

ggsave(
filename=file.path(outdir,"Mutation_KM.png"),
plot=p$plot,
width=8,
height=6,
dpi=300
)

write.table(
summary(cox)$coefficients,
file.path(outdir,"Mutation_Cox.tsv"),
sep="\t",
quote=FALSE
)

write.table(
driver_df,
file.path(outdir,"Mutation_KM.tsv"),
sep="\t",
quote=FALSE,
row.names=FALSE
)

write_json(
list(
driver=driver,
patients=nrow(driver_df),
mutated=sum(driver_df$Mutation==1),
wildtype=sum(driver_df$Mutation==0),
events=sum(driver_df$OS_event),
logrank_p=pvalue
),
file.path(outdir,"Mutation_LogRank.json"),
pretty=TRUE,
auto_unbox=TRUE
)

cat("Mutation Kaplan-Meier completed.\n")

}
