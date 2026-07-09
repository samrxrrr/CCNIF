lookup_empirical_percentile <- function(

value,

ecdf_file

){

d <- read.delim(

ecdf_file,

check.names=FALSE,

stringsAsFactors=FALSE

)

x <- d[[1]]
p <- d[[2]]

if(value <= min(x))
return(0)

if(value >= max(x))
return(1)

i <- max(which(x <= value))

x1 <- x[i]
x2 <- x[i+1]

p1 <- p[i]
p2 <- p[i+1]

if(x2==x1)
return(p1)

p1 + (value-x1)*(p2-p1)/(x2-x1)

}
