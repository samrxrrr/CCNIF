preprocess_driver_dataset <- function(driver_df){

cat("============================================\n")
cat("Preprocessing Driver Dataset\n")
cat("============================================\n")

driver_df$Expression_Log2 <- log2(driver_df$Expression + 1)

driver_df$Expression_Z <- as.numeric(
scale(driver_df$Expression_Log2)
)

cat("Raw range:\n")
print(range(driver_df$Expression))

cat("Log2 range:\n")
print(range(driver_df$Expression_Log2))

cat("Z-score range:\n")
print(range(driver_df$Expression_Z))

return(driver_df)

}
