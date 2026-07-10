library(jsonlite)

safe_load <- function(f){
if(!file.exists(f)) return(NULL)
read_json(f,simplifyVector=TRUE)
}

populate_distribution_report <- function(driver){

base <- file.path("results","evidence",driver,"Statistics")

r <- safe_load(file.path(base,"Distribution_Report.json"))

r$Characterization <-
safe_load(file.path(base,"Characterization.json"))

r$ECDF <-
safe_load(file.path(base,"ECDF_QC","Master_ECDF_Report.json"))

r$Interpolation <-
list(Method="Linear")

r$EmpiricalModel <-
safe_load(file.path(base,"Models","Transcriptomics_ECDF.json"))

r$ParametricFits <-
safe_load(file.path(base,"Model_Comparison.json"))

r$GoodnessOfFit <-
safe_load(file.path(base,"GOF.json"))

r$ModelComparison <-
safe_load(file.path(base,"Model_Comparison.json"))

if(!is.null(r$ModelComparison))
r$BestModel <- r$ModelComparison$BestModel

r

}
