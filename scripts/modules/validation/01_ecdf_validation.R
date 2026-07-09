library(jsonlite)

validate_ecdf <- function(ecdf_file){

cat("============================================\n")
cat("ECDF Validation\n")
cat("============================================\n")

tbl <- read.delim(
ecdf_file,
check.names=FALSE
)

report <- list()

report$Rows <- nrow(tbl)

report$Duplicates <- sum(duplicated(tbl$Value))

report$MissingValues <- sum(is.na(tbl$Value))

report$MissingPercentiles <- sum(is.na(tbl$Percentile))

report$MonotonicValue <- all(diff(tbl$Value)>=0)

report$MonotonicPercentile <- all(diff(tbl$Percentile)>=0)

report$MinimumValue <- min(tbl$Value)

report$MaximumValue <- max(tbl$Value)

report$MinimumPercentile <- min(tbl$Percentile)

report$MaximumPercentile <- max(tbl$Percentile)

report$BoundaryCheck <-
(
report$MinimumPercentile>=0 &
report$MaximumPercentile<=1
)

report

}
