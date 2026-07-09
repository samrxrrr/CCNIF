build_clinical_distribution <- function(driver){

cat("============================================\n")
cat("Clinical Distribution Engine\n")
cat("============================================\n")

base <- file.path("results","evidence",driver)

cox <- read.delim(
file.path(base,"Clinical","Multivariate_Cox.tsv"),
check.names=FALSE
)

cox <- cox[order(cox$Pvalue),]

cox$Rank <- seq_len(nrow(cox))

cox$Percentile <- round(
(cox$Rank-1)/(nrow(cox)-1),
6
)

out <- cox[,c(
"Variable",
"HR",
"Lower95",
"Upper95",
"Pvalue",
"Rank",
"Percentile"
)]

dir.create(
file.path(base,"Statistics"),
recursive=TRUE,
showWarnings=FALSE
)

write.table(
out,
file.path(
base,
"Statistics",
"Clinical_Distribution.tsv"
),
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("Rows exported :",nrow(out),"\n")
cat("Distribution exported.\n")

}
