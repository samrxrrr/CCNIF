library(jsonlite)

load_statistics <- function(driver){

base <- file.path(
"results",
"evidence",
driver,
"Statistics"
)

list(

Distribution =
read_json(
file.path(base,"Distribution_Report.json"),
simplifyVector=TRUE
),

Reliability =
read_json(
file.path(base,"Reliability_Report.json"),
simplifyVector=TRUE
),

Normalization =
read_json(
file.path(base,"Normalization_Report.json"),
simplifyVector=TRUE
),

Quality =
read_json(
file.path(base,"Quality_Report.json"),
simplifyVector=TRUE
),

Confidence =
read_json(
file.path(base,"Confidence_Report.json"),
simplifyVector=TRUE
)

)

}
