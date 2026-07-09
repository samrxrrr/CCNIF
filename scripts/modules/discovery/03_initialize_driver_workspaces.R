library(data.table)

initialize_driver_workspaces <- function(){

cat("=====================================\n")
cat("INITIALIZE DRIVER WORKSPACES\n")
cat("=====================================\n")

queue <- fread("results/registry/Driver_Queue.tsv")

created <- data.frame(
Driver=character(),
Workspace=character(),
stringsAsFactors=FALSE
)

for(i in seq_len(nrow(queue))){

driver <- as.character(queue$gene_name[i])

base <- file.path("results","evidence",driver)

dirs <- c(
"Evidence",
"Statistics",
"Statistics/Models",
"Statistics/Diagnostics",
"Statistics/Reliability",
"Statistics/ECDF",
"transcriptomics"
)

for(d in dirs){

dir.create(
file.path(base,d),
recursive=TRUE,
showWarnings=FALSE
)

}

created <- rbind(
created,
data.frame(
Driver=driver,
Workspace=base,
stringsAsFactors=FALSE
)
)

}

write.table(
created,
"results/registry/Workspace_Manifest.tsv",
sep="\t",
quote=FALSE,
row.names=FALSE
)

cat("Workspaces initialized:",nrow(created),"\n")

created

}
