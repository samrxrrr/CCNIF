suppressPackageStartupMessages({

library(DESeq2)
library(EnhancedVolcano)
library(ggplot2)
library(pheatmap)
library(jsonlite)

})

create_dir <- function(path){

if(!dir.exists(path))
dir.create(path,recursive=TRUE)

}

save_json <- function(object,file){

write(
toJSON(
object,
pretty=TRUE,
auto_unbox=TRUE
),
file=file
)

}
