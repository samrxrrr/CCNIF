library(jsonlite)

source("scripts/modules/characterization/01_shape.R")
source("scripts/modules/characterization/02_tail.R")
source("scripts/modules/characterization/03_dispersion.R")
source("scripts/modules/characterization/04_outlier_burden.R")

characterize_distribution <- function(stats){

list(

Shape=shape_class(stats$Skewness),

Tail=tail_class(stats$Kurtosis),

Dispersion=dispersion_class(stats$CV),

OutlierBurden=outlier_class(

stats$OutlierCount /

stats$N

)

)

}
