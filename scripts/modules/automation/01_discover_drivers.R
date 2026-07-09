discover_drivers <- function(base="results/evidence"){

if(!dir.exists(base))
stop("Evidence directory not found.")

dirs <- list.dirs(
base,
recursive=FALSE,
full.names=FALSE
)

dirs <- dirs[dirs!=""]

dirs <- dirs[file.exists(
file.path(
base,
dirs,
"Evidence",
"Transcriptomics_Evidence.json"
)
)]

dirs <- sort(unique(dirs))

cat("=====================================\n")
cat("Drivers discovered\n")
cat("=====================================\n")

print(dirs)

dirs

}
