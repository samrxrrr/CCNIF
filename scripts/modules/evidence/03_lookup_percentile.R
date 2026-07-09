lookup_percentile <- function(object, ecdf_file){

tbl <- read.delim(
ecdf_file,
check.names=FALSE
)

tbl <- tbl[order(tbl$Value),]

obs <- object$Raw$Observed

if(obs <= min(tbl$Value)){

pct <- 0

}else if(obs >= max(tbl$Value)){

pct <- 1

}else{

i <- max(which(tbl$Value <= obs))
j <- min(which(tbl$Value >= obs))

x1 <- tbl$Value[i]
x2 <- tbl$Value[j]

y1 <- tbl$Percentile[i]
y2 <- tbl$Percentile[j]

if(x1 == x2){

pct <- y1

}else{

pct <- y1 + (obs-x1)*(y2-y1)/(x2-x1)

}

}

object$Distribution$ECDF <- ecdf_file
object$Distribution$Percentile <- pct
object$Distribution$Rank <- NA

object

}
