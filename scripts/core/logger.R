log_message <- function(driver,message){

entry <- list(

time=as.character(Sys.time()),

message=message

)

driver$logs[[length(driver$logs)+1]] <- entry

cat(

sprintf(

"[%s] %s\n",

entry$time,

message

)

)

return(driver)

}
