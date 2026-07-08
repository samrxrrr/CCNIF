export_communities <- function(driver,res){

library(jsonlite)

outdir <- file.path(
"results",
"evidence",
driver,
"STRING"
)

write.table(

res$membership,

file.path(outdir,"Community_Assignments.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

write.table(

res$summary,

file.path(outdir,"Community_Summary.tsv"),

sep="\t",

quote=FALSE,

row.names=FALSE

)

write(

toJSON(

list(

communities=nrow(res$summary),

largest=max(res$summary$Size)

),

pretty=TRUE,

auto_unbox=TRUE

),

file.path(

outdir,

"community_summary.json"

)

)

cat("Community analysis exported.\n")

}
