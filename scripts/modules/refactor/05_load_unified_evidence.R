library(jsonlite)

load_unified_evidence <- function(driver){

cat("=====================================\n")
cat("LOADING UNIFIED EVIDENCE\n")
cat("=====================================\n")
cat("Driver:",driver,"\n\n")

f <- file.path(
"results",
"evidence",
driver,
"Evidence",
"Unified_Evidence.json"
)

if(!file.exists(f))
stop("Unified_Evidence.json not found")

x <- read_json(
f,
simplifyVector=TRUE
)

cat("Loaded sections:\n")
print(names(x))

x

}
