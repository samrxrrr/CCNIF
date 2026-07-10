library(data.table)

calculate_bootstrap <- function(driver){

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
stop("Too few observations for bootstrap.")

set.seed(123)

B <- 1000

boot.mean <- replicate(
B,
mean(sample(x,length(x),replace=TRUE))
)

se <- sd(boot.mean)

ci <- quantile(
boot.mean,
c(0.025,0.975)
)

width <- unname(ci[2]-ci[1])

score <- max(
0,
100-(width*100)
)

list(

Metric="Bootstrap",

Driver=driver,

Iterations=B,

N=length(x),

BootstrapSE=round(se,6),

Lower95=round(ci[1],6),

Upper95=round(ci[2],6),

CIWidth=round(width,6),

Score=round(score,4)

)

}
