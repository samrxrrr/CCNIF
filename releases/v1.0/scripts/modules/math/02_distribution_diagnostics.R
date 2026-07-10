library(jsonlite)

source("scripts/modules/math/01_math_utils.R")

distribution_diagnostics <- function(x){

x <- x[is.finite(x)]

q <- quantile(
x,
c(.01,.05,.10,.25,.50,.75,.90,.95,.99)
)

lim <- tukey_limits(x)

list(

N=length(x),

Minimum=min(x),

Maximum=max(x),

Mean=safe_mean(x),

Median=safe_median(x),

Variance=safe_var(x),

SD=safe_sd(x),

MAD=safe_mad(x),

IQR=safe_iqr(x),

Q1=unname(quantile(x,.25)),

Q3=unname(quantile(x,.75)),

P01=unname(q[1]),

P05=unname(q[2]),

P10=unname(q[3]),

P25=unname(q[4]),

P50=unname(q[5]),

P75=unname(q[6]),

P90=unname(q[7]),

P95=unname(q[8]),

P99=unname(q[9]),

Skewness=safe_skewness(x),

Kurtosis=safe_kurtosis(x),

CV=if(abs(safe_mean(x))<1e-8) NA else safe_cv(x),

OutlierLower=lim$Lower,

OutlierUpper=lim$Upper,

OutlierCount=outlier_count(x)

)

}

build_distribution_model <- function(driver,
distribution_file,
model_name){

cat("============================================\n")
cat(model_name,"\n")
cat("============================================\n")

base <- file.path("results","evidence",driver)

tbl <- read.delim(
file.path(base,"Statistics",distribution_file),
check.names=FALSE
)

out <- list()

for(col in names(tbl)){

if(is.numeric(tbl[[col]]))

out[[col]] <- distribution_diagnostics(tbl[[col]])

}

dir.create(
file.path(base,"Statistics","Diagnostics"),
recursive=TRUE,
showWarnings=FALSE
)

write_json(

out,

file.path(

base,

"Statistics",

"Diagnostics",

paste0(model_name,"_Diagnostics.json")

),

pretty=TRUE,

auto_unbox=TRUE

)

cat("Finished.\n")

}
