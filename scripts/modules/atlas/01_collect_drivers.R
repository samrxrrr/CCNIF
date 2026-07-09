collect_drivers <- function(base="results/evidence"){

dirs <- list.dirs(
base,
recursive=FALSE,
full.names=FALSE
)

dirs[nzchar(dirs)]

}
