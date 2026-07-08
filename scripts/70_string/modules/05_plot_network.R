plot_network <- function(driver,g){

library(ggraph)
library(ggplot2)

figdir <- file.path(
"figures",
"evidence",
driver
)

dir.create(
figdir,
recursive=TRUE,
showWarnings=FALSE
)

p <-
ggraph(
g,
layout="fr"
)+
geom_edge_link(alpha=.25)+
geom_node_point(size=3)+
theme_void()

ggsave(
file.path(
figdir,
"STRING_Network.png"
),
p,
width=10,
height=8,
dpi=300
)

cat("Network figure saved.\n")

}
