shrink_lfc <- function(dds){

library(DESeq2)
library(apeglm)

coef_name <- resultsNames(dds)[2]

cat("============================================\n")
cat("Applying apeglm LFC shrinkage\n")
cat("============================================\n")

res_shrunk <- lfcShrink(
    dds,
    coef = coef_name,
    type = "apeglm"
)

cat("Shrinkage completed.\n")

return(res_shrunk)

}
