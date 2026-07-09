library(jsonlite)

populate_distribution <- function(

object,

diagnostics_file,

ecdf_file

){

object$Diagnostics <-
jsonlite::read_json(
diagnostics_file,
simplifyVector=TRUE
)

object$Distribution$ECDF <-
ecdf_file

object

}
