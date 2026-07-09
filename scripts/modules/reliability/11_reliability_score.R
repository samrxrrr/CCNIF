
source("scripts/modules/reliability/01_sample_size.R")
source("scripts/modules/reliability/02_missingness.R")
source("scripts/modules/reliability/03_precision.R")
source("scripts/modules/reliability/04_dispersion.R")
source("scripts/modules/reliability/05_stability.R")
source("scripts/modules/reliability/06_outliers.R")
source("scripts/modules/reliability/07_bootstrap.R")
source("scripts/modules/reliability/08_confidence_intervals.R")
source("scripts/modules/reliability/09_power.R")
source("scripts/modules/reliability/10_influence.R")

calculate_reliability_score <- function(driver){

scores <- c(

calculate_sample_size(driver)$Score,

calculate_missingness(driver)$Score,

calculate_precision(driver)$Score,

calculate_dispersion(driver)$Score,

calculate_stability(driver)$Score,

calculate_outliers(driver)$Score,

calculate_bootstrap(driver)$Score,

calculate_confidence_intervals(driver)$Score,

calculate_power(driver)$Score,

calculate_influence(driver)$Score

)

list(

Driver=driver,

ReliabilityScore=round(mean(scores),4),

Modules=length(scores),

Scores=scores

)

}
