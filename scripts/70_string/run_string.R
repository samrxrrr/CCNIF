args <- commandArgs(trailingOnly=TRUE)

if(length(args)!=1)
stop("Usage: Rscript run_string.R TP53")

driver <- args[1]

source("scripts/70_string/modules/00_load_deg.R")
source("scripts/70_string/modules/01_prepare_string.R")
source("scripts/70_string/modules/02_download_network.R")
source("scripts/70_string/modules/03_build_graph.R")
source("scripts/70_string/modules/04_export_network.R")
source("scripts/70_string/modules/05_plot_network.R")
source("scripts/70_string/modules/06_network_metrics.R")
source("scripts/70_string/modules/07_export_metrics.R")
source("scripts/70_string/modules/08_community_detection.R")
source("scripts/70_string/modules/09_export_communities.R")

deg <- load_deg(driver)

obj <- prepare_string(deg)

network <- download_network(obj)

g <- build_graph(network,obj$mapped)

export_network(driver,network,g)

plot_network(driver,g)

metrics <- network_metrics(g)

export_metrics(driver,metrics)

community <- community_detection(g)

export_communities(driver,community)

cat("\n=====================================\n")
cat("STRING + Community Analysis completed\n")
cat("=====================================\n")
