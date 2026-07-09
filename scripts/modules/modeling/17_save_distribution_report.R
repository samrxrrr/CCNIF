library(jsonlite)

save_distribution_report <- function(report,file){

write_json(

report,

file,

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

}
