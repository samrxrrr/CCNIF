load_registry <- function(){

read.delim(

"config/variable_registry.tsv",

check.names=FALSE,

stringsAsFactors=FALSE

)

}

get_variable_info <- function(variable){

reg <- load_registry()

x <- reg[reg$Variable==variable,]

if(nrow(x)==0){

return(NULL)

}

x

}
