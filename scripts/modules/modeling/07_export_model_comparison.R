library(jsonlite)

export_model_comparison <- function(result,file){

write.table(

result$Summary,

sub("\\.json$",".tsv",file),

sep="\t",

row.names=FALSE,

quote=FALSE

)

write_json(

list(

BestModel=result$BestModel,

Models=nrow(result$Summary)

),

file,

pretty=TRUE,

auto_unbox=TRUE

)

cat("Model comparison exported.\n")

}
