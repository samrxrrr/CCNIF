prepare_transcriptomics <- function(driver){

src <- file.path(
"data",
"transcriptomics",
"DEGs.tsv"
)

dst_dir <- file.path(
"results",
"evidence",
driver,
"transcriptomics"
)

dir.create(
dst_dir,
recursive=TRUE,
showWarnings=FALSE
)

dst <- file.path(
dst_dir,
"DEGs.tsv"
)

file.copy(
src,
dst,
overwrite=TRUE
)

cat("Transcriptomics prepared for",driver,"\n")

invisible(dst)

}
