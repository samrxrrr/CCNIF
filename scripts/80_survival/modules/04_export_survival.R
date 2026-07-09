export_survival <- function(driver,clinical){

dir.create(
file.path(
"results",
"evidence",
driver,
"Survival"
),
recursive=TRUE,
showWarnings=FALSE
)

write.table(

clinical,

file.path(
"results",
"evidence",
driver,
"Survival",
"Clinical_Survival.tsv"
),

sep="\t",

quote=FALSE,

row.names=FALSE

)

cat("Clinical survival exported.\n")

}
