
source("scripts/modules/reliability/11_reliability_score.R")

build_reliability_pipeline <- function(driver){

cat("=====================================\n")
cat("RELIABILITY PIPELINE\n")
cat("=====================================\n")

result <- calculate_reliability_score(driver)

print(result)

result

}
