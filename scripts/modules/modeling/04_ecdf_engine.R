library(jsonlite)

build_ecdf_model <- function(driver,
                             distribution_file,
                             model_name){

cat("============================================\n")
cat(paste(model_name,"ECDF Model\n"))
cat("============================================\n")

base <- file.path("results","evidence",driver)

tbl <- read.delim(
file.path(base,"Statistics",distribution_file),
check.names=FALSE
)

ecdf_model <- list()

ecdf_model$Driver <- driver
ecdf_model$Rows <- nrow(tbl)

for(col in names(tbl)){

if(is.numeric(tbl[[col]])){

x <- tbl[[col]]
x <- x[is.finite(x)]

Fn <- ecdf(x)

probes <- c(
0.01,
0.05,
0.10,
0.25,
0.50,
0.75,
0.90,
0.95,
0.99
)

values <- as.numeric(
quantile(
x,
probes,
na.rm=TRUE
)
)

ecdf_model[[col]] <- list(

Percentiles=as.list(values)

)

names(ecdf_model[[col]]$Percentiles) <-
paste0("P",c(1,5,10,25,50,75,90,95,99))

}

}

dir.create(
file.path(base,"Statistics","Models"),
recursive=TRUE,
showWarnings=FALSE
)

write_json(
ecdf_model,
file.path(
base,
"Statistics",
"Models",
paste0(model_name,"_ECDF.json")
),
pretty=TRUE,
auto_unbox=TRUE
)

cat(model_name,"ECDF exported.\n")

}
