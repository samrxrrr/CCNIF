library(jsonlite)

load_statistics <- function(object,model_file){

model <- read_json(
model_file,
simplifyVector=TRUE
)

var <- object$Metadata$Variable

if(!var %in% names(model))
return(object)

object$Statistics <- model[[var]]

object

}
