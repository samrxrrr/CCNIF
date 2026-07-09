library(jsonlite)

load_driver_report <- function(driver){

read_json(

file.path(

"results",
"evidence",
driver,
"Driver_Report.json"

),

simplifyVector=TRUE

)

}
