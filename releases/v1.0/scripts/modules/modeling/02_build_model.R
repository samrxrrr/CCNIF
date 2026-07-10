library(jsonlite)

source("scripts/modules/modeling/01_statistics_engine.R")

build_model <- function(driver,
                        distribution_file,
                        model_name){

cat("============================================\n")
cat(paste(model_name,"Statistical Model\n"))
cat("============================================\n")

base <- file.path("results","evidence",driver)

tbl <- read.delim(
file.path(base,"Statistics",distribution_file),
check.names=FALSE
)

model <- list()

model$Driver <- driver
model$Rows <- nrow(tbl)

for(col in names(tbl)){

if(is.numeric(tbl[[col]])){

model[[col]] <- describe_numeric(tbl[[col]])

}

}

dir.create(
file.path(base,"Statistics","Models"),
recursive=TRUE,
showWarnings=FALSE
)

jsonlite::write_json(
model,
file.path(
base,
"Statistics",
"Models",
paste0(model_name,"_Model.json")
),
pretty=TRUE,
auto_unbox=TRUE
)

cat(model_name,"model exported.\n")

}
