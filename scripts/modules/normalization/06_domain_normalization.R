source("scripts/modules/normalization/02_variable_direction.R")
source("scripts/modules/normalization/03_empirical_percentile.R")
source("scripts/modules/normalization/04_probability_transform.R")
source("scripts/modules/normalization/05_score_scaling.R")

normalize_variable <- function(

domain,
variable,
value,
ecdf_file

){

direction <- lookup_direction(

domain,
variable

)

percentile <- lookup_empirical_percentile(

value,
ecdf_file

)

probability <- probability_transform(

percentile,
direction

)

score <- scale_score(

probability

)

list(

Domain=domain,
Variable=variable,
Observed=value,
Direction=direction,
Percentile=percentile,
Probability=probability,
NormalizedScore=score

)

}
