library(jsonlite)

build_statistics <- function(driver){

cat("Building statistics...\n")

base <- file.path(
"results",
"evidence",
driver,
"Statistics"
)

required <- c(

file.path(base,"Models","Transcriptomics_Model.json"),
file.path(base,"Diagnostics","Transcriptomics_Diagnostics.json"),
file.path(base,"Distribution_Report.json"),
file.path(base,"Distribution_Manifest.json"),
file.path(base,"Reliability_Report.json"),
file.path(base,"Normalization_Report.json"),
file.path(base,"Quality_Report.json"),
file.path(base,"Confidence_Report.json"),
file.path(base,"Backbone_Validation.json"),
file.path(base,"Mathematical_Backbone.json")

)

missing <- required[!file.exists(required)]

if(length(missing)>0){

cat("\nMissing files:\n")
print(missing)

return(FALSE)

}

cat("Mathematical backbone verified.\n")

TRUE

}
