check_driver_status <- function(driver){

base <- file.path("results","evidence",driver)

checks <- c(

Evidence=file.exists(file.path(base,"Evidence","Transcriptomics_Evidence.json")),

Statistics=file.exists(file.path(base,"Statistics","Models","Transcriptomics_Model.json")),

Diagnostics=file.exists(file.path(base,"Statistics","Diagnostics","Transcriptomics_Diagnostics.json")),

Distribution=file.exists(file.path(base,"Statistics","Distribution_Report.json")),

Reliability=file.exists(file.path(base,"Statistics","Reliability_Report.json")),

Normalization=file.exists(file.path(base,"Statistics","Normalization_Report.json")),

Quality=file.exists(file.path(base,"Statistics","Quality_Report.json")),

Confidence=file.exists(file.path(base,"Statistics","Confidence_Report.json")),

DriverReport=file.exists(file.path(base,"Driver_Report.json")),

DriverManifest=file.exists(file.path(base,"Driver_Manifest.json"))

)

list(

Driver=driver,

Checks=checks,

Passed=sum(checks),

Failed=sum(!checks),

Complete=all(checks)

)

}
