read_registry <- function(){

read.delim(

"config/variable_registry.tsv",

check.names=FALSE,

stringsAsFactors=FALSE

)

}

lookup_direction <- function(

domain,

variable

){

r <- read_registry()

x <- r[

r$Domain==domain &

r$Variable==variable,

]

if(nrow(x)==0)
stop("Variable not registered.")

if(x$Positive[1]){

"HIGHER_BETTER"

}else{

"LOWER_BETTER"

}

}

