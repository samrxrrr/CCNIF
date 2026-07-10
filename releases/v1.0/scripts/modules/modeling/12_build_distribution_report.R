library(jsonlite)

safe_load <- function(file){

if(!file.exists(file))
return(NULL)

read_json(

file,

simplifyVector=TRUE

)

}

build_distribution_report <- function(

driver,

domain,

variable,

base_dir

){

report <- new_distribution_report()

report$Metadata$Driver <- driver
report$Metadata$Domain <- domain
report$Metadata$Variable <- variable

stats_file <- file.path(

base_dir,

"Statistics",

"Models",

paste0(domain,"_Model.json")

)

diag_file <- file.path(

base_dir,

"Statistics",

"Diagnostics",

paste0(domain,"_Diagnostics.json")

)

gof_file <- file.path(

base_dir,

"Statistics",

"Models",

"Goodness_of_Fit.json"

)

comparison_file <- file.path(

base_dir,

"Statistics",

"Models",

"Model_Comparison.json"

)

report$Statistics <- safe_load(stats_file)

report$Diagnostics <- safe_load(diag_file)

report$GoodnessOfFit <- safe_load(gof_file)

report$ModelComparison <- safe_load(comparison_file)

if(

!is.null(report$ModelComparison)

){

report$BestModel <-

report$ModelComparison$BestModel

}

report

}
