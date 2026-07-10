library(jsonlite)

export_driver_report <- function(

report,
driver

){

out <- file.path(

"results",
"evidence",
driver,
"Driver_Report.json"

)

write_json(

report,

out,

pretty=TRUE,

auto_unbox=TRUE,

null="null"

)

cat("Driver report exported.\n")

}
