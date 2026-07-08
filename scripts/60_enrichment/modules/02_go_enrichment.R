run_go <- function(deg_table){

library(clusterProfiler)
library(org.Hs.eg.db)

source("scripts/60_enrichment/modules/00_convert_ids.R")
source("scripts/60_enrichment/modules/01_filter_deg.R")

deg_table <- filter_deg(deg_table)

mapping <- convert_gene_ids(deg_table)

ego_bp <- enrichGO(
    gene          = mapping$ENTREZID,
    OrgDb         = org.Hs.eg.db,
    keyType       = "ENTREZID",
    ont           = "BP",
    pAdjustMethod = "BH",
    readable      = TRUE
)

ego_mf <- enrichGO(
    gene          = mapping$ENTREZID,
    OrgDb         = org.Hs.eg.db,
    keyType       = "ENTREZID",
    ont           = "MF",
    pAdjustMethod = "BH",
    readable      = TRUE
)

ego_cc <- enrichGO(
    gene          = mapping$ENTREZID,
    OrgDb         = org.Hs.eg.db,
    keyType       = "ENTREZID",
    ont           = "CC",
    pAdjustMethod = "BH",
    readable      = TRUE
)

list(
    BP = ego_bp,
    MF = ego_mf,
    CC = ego_cc,
    mapping = mapping,
    filtered = deg_table
)

}
