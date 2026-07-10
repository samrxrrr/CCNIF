library(jsonlite)

safe_load <- function(f){

if(!file.exists(f))
return(NULL)

read_json(f,simplifyVector=TRUE)

}

populate_reliability_report <- function(driver){

base <- file.path("results","evidence",driver,"Statistics")

r <- safe_load(file.path(base,"Reliability_Report.json"))

r$SampleSize <-
safe_load(file.path(base,"Reliability","SampleSize.json"))

r$Missingness <-
safe_load(file.path(base,"Reliability","Missingness.json"))

r$Precision <-
safe_load(file.path(base,"Reliability","Precision.json"))

r$Dispersion <-
safe_load(file.path(base,"Reliability","Dispersion.json"))

r$Stability <-
safe_load(file.path(base,"Reliability","Stability.json"))

r$Outliers <-
safe_load(file.path(base,"Reliability","Outliers.json"))

r$Bootstrap <-
safe_load(file.path(base,"Reliability","Bootstrap.json"))

r$ConfidenceIntervals <-
safe_load(file.path(base,"Reliability","ConfidenceIntervals.json"))

r$Power <-
safe_load(file.path(base,"Reliability","Power.json"))

r$Influence <-
safe_load(file.path(base,"Reliability","Influence.json"))

r

}
