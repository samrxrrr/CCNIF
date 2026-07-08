load_module <- function(module){

module_file <- paste0(
"scripts/60_enrichment/modules/",
module,
".R"
)

if(!file.exists(module_file)){

stop(
paste(
"Module not found:",
module_file
)
)

}

source(module_file)

}
