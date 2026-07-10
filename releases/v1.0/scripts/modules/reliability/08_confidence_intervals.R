library(data.table)

calculate_confidence_intervals <- function(driver){

tbl <- fread(
file.path(
"results",
"evidence",
driver,
"Statistics",
"Transcriptomics_Distribution.tsv"
)
)

x <- as.numeric(tbl$AbsLog2FC)
x <- x[is.finite(x)]

if(length(x)<30)
stop("Too few observations.")

n <- length(x)

m <- mean(x)

se <- sd(x)/sqrt(n)

lower <- m-1.96*se
upper <- m+1.96*se

width <- upper-lower

score <- max(
0,
100-(width*100)
)

list(

Metric="ConfidenceIntervals",

Driver=driver,

N=n,

Mean=round(m,6),

SE=round(se,6),

Lower95=round(lower,6),

Upper95=round(upper,6),

CIWidth=round(width,6),

Score=round(score,4)

)

}
