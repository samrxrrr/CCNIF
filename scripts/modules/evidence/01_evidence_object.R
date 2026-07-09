library(jsonlite)

new_evidence_object <- function(
driver,
domain,
variable,
value,
units=NULL,
direction=NULL,
source=NULL
){

list(

Metadata=list(
Driver=driver,
Domain=domain,
Variable=variable,
Source=source,
Version="2.0",
Created=as.character(Sys.time())
),

Raw=list(
Observed=value,
Units=units,
Direction=direction
),

Statistics=list(
Mean=NULL,
Median=NULL,
SD=NULL,
MAD=NULL,
Variance=NULL,
IQR=NULL,
Skewness=NULL,
Kurtosis=NULL,
CV=NULL
),

Distribution=list(
ECDF=NULL,
Percentile=NULL,
Rank=NULL,
Outlier=NULL,
OutlierMethod=NULL
),

Normalization=list(
Method=NULL,
RawScore=NULL,
NormalizedScore=NULL,
PercentileScore=NULL
),

Reliability=list(
SampleSize=NULL,
Missingness=NULL,
Stability=NULL,
Score=NULL
),

Quality=list(
Strength=NULL,
Reliability=NULL,
Score=NULL,
Tier=NULL
),

Confidence=list(
IntegratedScore=NULL,
Tier=NULL,
Explanation=NULL
),

Audit=list(
PipelineVersion="CCNIF-1.0",
Timestamp=as.character(Sys.time()),
QC=NULL,
Notes=NULL
)

)

}
