run_batch <- function(drivers){

results <- data.frame(
Driver=character(),
Status=character(),
Runtime=numeric(),
stringsAsFactors=FALSE
)

for(driver in drivers){

cat("\n==============================\n")
cat("Driver:",driver,"\n")
cat("==============================\n")

start <- Sys.time()

status <- tryCatch({

system(
paste("Rscript scripts/run_driver.R",driver),
intern=FALSE,
ignore.stdout=FALSE,
ignore.stderr=FALSE
)

"SUCCESS"

},error=function(e){

"FAILED"

})

runtime <- as.numeric(
difftime(Sys.time(),start,units="secs")
)

results <- rbind(
results,
data.frame(
Driver=driver,
Status=status,
Runtime=runtime,
stringsAsFactors=FALSE
)
)

}

results

}
