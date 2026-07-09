create_driver <- function(driver_name){

driver <- list(

metadata=list(
name=driver_name,
created=as.character(Sys.time()),
version="2.0",
status="initialized"
),

inputs=list(
clinical=NULL,
expression=NULL,
mutation=NULL
),

analyses=list(

transcriptomics=NULL,

enrichment=list(
GO=NULL,
KEGG=NULL,
Hallmark=NULL,
DiseaseOntology=NULL,
Reactome=NULL
),

network=list(
STRING=NULL,
Centrality=NULL,
Communities=NULL
),

survival=list(
Expression=NULL,
Mutation=NULL,
Cox=NULL
)

),

evidence=list(),

outputs=list(
tables=list(),
figures=list(),
reports=list()
),

logs=list()

)

class(driver) <- "CCNIFDriver"

driver

}
