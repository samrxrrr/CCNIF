library(jsonlite)

save_reliability_report <- function(report,file){

write_json(

report,

file,

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

}
