library(jsonlite)
library(data.table)

safe_json <- function(f){

if(file.exists(f)){

read_json(f,simplifyVector=TRUE)

}else{

NULL

}

}

build_master_index <- function(){

cat("=====================================\n")
cat("CCNIF MASTER INDEX\n")
cat("=====================================\n")

drivers <- basename(
list.dirs(
file.path("results","evidence"),
recursive=FALSE,
full.names=TRUE
)
)

master <- rbindlist(lapply(drivers,function(driver){

base <- file.path("results","evidence",driver)

rel  <- safe_json(file.path(base,"Statistics","Reliability_Report.json"))
norm <- safe_json(file.path(base,"Statistics","Normalization_Report.json"))
qual <- safe_json(file.path(base,"Statistics","Quality_Report.json"))
conf <- safe_json(file.path(base,"Statistics","Confidence_Report.json"))

data.table(

Driver=driver,

NormalizedScore=if(is.null(norm)) NA_real_ else norm$NormalizedScore,

ReliabilityScore=if(is.null(rel)) NA_real_ else rel$ReliabilityScore,

QualityScore=if(is.null(qual)) NA_real_ else qual$QualityScore,

QualityTier=if(is.null(qual)) NA_character_ else qual$QualityTier,

DriverConfidence=if(is.null(conf)) NA_real_ else conf$DriverConfidence,

ConfidenceTier=if(is.null(conf)) NA_character_ else conf$ConfidenceTier,

Completed=
file.exists(file.path(base,"Driver_Report.json")) &&
file.exists(file.path(base,"Driver_Manifest.json")),

DriverReport=file.path(base,"Driver_Report.json"),

DriverManifest=file.path(base,"Driver_Manifest.json")

)

}),fill=TRUE)

setorder(master,-DriverConfidence,-QualityScore,-ReliabilityScore)

master[,Rank:=seq_len(.N)]

setcolorder(master,c(

"Rank",
"Driver",
"DriverConfidence",
"ConfidenceTier",
"QualityScore",
"QualityTier",
"ReliabilityScore",
"NormalizedScore",
"Completed",
"DriverReport",
"DriverManifest"

))

dir.create("results/master",recursive=TRUE,showWarnings=FALSE)

fwrite(master,
"results/master/Driver_Master_Index.tsv",
sep="\t")

fwrite(master,
"results/master/Driver_Master_Index.csv")

write_json(
split(master,seq_len(nrow(master))),
"results/master/Driver_Master_Index.json",
pretty=TRUE,
auto_unbox=TRUE
)

cat("\nDrivers :",nrow(master),"\n")
cat("Completed :",sum(master$Completed),"\n")
cat("\nMaster index exported.\n")

print(head(master,20))

invisible(master)

}

build_master_index()
