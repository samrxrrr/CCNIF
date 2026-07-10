download_network <- function(string_obj){

cat("============================================\n")
cat("Downloading STRING Network\n")
cat("============================================\n")

db <- string_obj$db
mapped <- string_obj$mapped

network <- db$get_interactions(mapped$STRING_id)

network <- network[
network$from %in% mapped$STRING_id &
network$to %in% mapped$STRING_id,
]

cat("Edges:",nrow(network),"\n")

return(network)

}
