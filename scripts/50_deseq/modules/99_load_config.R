load_config <- function(){

library(jsonlite)

cfg <- fromJSON(
    "config/analysis_config.json",
    simplifyVector = TRUE
)

return(cfg)

}
