library(jsonlite)

describe_numeric <- function(x){

x <- x[is.finite(x)]

list(

N=length(x),

Missing=sum(is.na(x)),

Minimum=min(x),

Maximum=max(x),

Mean=mean(x),

Median=median(x),

Variance=var(x),

SD=sd(x),

MAD=mad(x),

IQR=IQR(x),

Q1=unname(quantile(x,0.25)),

Q3=unname(quantile(x,0.75)),

P05=unname(quantile(x,0.05)),

P10=unname(quantile(x,0.10)),

P25=unname(quantile(x,0.25)),

P50=unname(quantile(x,0.50)),

P75=unname(quantile(x,0.75)),

P90=unname(quantile(x,0.90)),

P95=unname(quantile(x,0.95)),

P99=unname(quantile(x,0.99))

)

}

save_model <- function(model,file){

write_json(

model,

file,

pretty=TRUE,

auto_unbox=TRUE

)

}
