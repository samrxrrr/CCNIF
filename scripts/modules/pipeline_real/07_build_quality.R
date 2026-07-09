library(jsonlite)

source("scripts/modules/quality/01_strength.R")
source("scripts/modules/quality/02_reliability.R")
source("scripts/modules/quality/03_consistency.R")
source("scripts/modules/quality/04_quality_score.R")
source("scripts/modules/quality/05_quality_tier.R")
source("scripts/modules/quality/06_quality_report.R")

build_quality <- function(

normalized_score,
sample_size,
missing_fraction,
outlier_fraction,
cv,
skewness

){

s <- strength_score(normalized_score)

r <- reliability_score(
sample_size,
missing_fraction,
outlier_fraction
)

c <- consistency_score(
cv,
skewness,
outlier_fraction
)

q <- quality_score(
s,
r,
c
)

report <- new_quality_report()

report$Strength <- s
report$Reliability <- r
report$Consistency <- c

report$QualityScore <- q
report$QualityTier <- quality_tier(q)

report$Interpretation <- paste(

"Evidence quality:",

report$QualityTier

)

report

}
