validate_project <- function(){

required <- c(

"config/analysis_config.json",
"config/modules.json",

"data/processed/final/expression_matched.tsv.gz",
"data/processed/final/mutation_matrix_matched.tsv",
"data/processed/final/clinical_master_matched.tsv"

)

cat("=========================================\n")
cat("Validating Project\n")
cat("=========================================\n")

missing <- required[!file.exists(required)]

if(length(missing)>0){

cat("\nMissing files:\n")

print(missing)

stop("Project validation failed.")

}

cat("All required files detected.\n")

}
