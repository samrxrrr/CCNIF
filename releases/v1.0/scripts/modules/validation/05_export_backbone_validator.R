library(jsonlite)

export_backbone_validation <- function(report,file){

write_json(

report,

file,

pretty=TRUE,

auto_unbox=TRUE

)

}
