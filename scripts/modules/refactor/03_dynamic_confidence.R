library(jsonlite)

source("scripts/modules/refactor/02_dynamic_quality.R")
source("scripts/modules/confidence/04_build_confidence.R")

dynamic_confidence <- function(driver){

q <- dynamic_quality(driver)

build_driver_confidence(

quality=q$QualityScore,
normalized_score=q$Strength,
reliability=q$Reliability

)

}
