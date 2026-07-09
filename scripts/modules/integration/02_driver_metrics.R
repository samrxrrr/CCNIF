extract_driver_metrics <- function(x){

list(

NormalizedScore =
x$Normalization$NormalizedScore,

Quality =
x$Quality$QualityScore,

Reliability =
x$Quality$Reliability,

Confidence =
x$Confidence$DriverConfidence,

ConfidenceTier =
x$Confidence$ConfidenceTier

)

}
