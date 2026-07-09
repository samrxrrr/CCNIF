library(ggplot2)

plot_forest <- function(driver){

cox <- read.delim(
file.path(
"results",
"evidence",
driver,
"Clinical",
"Multivariate_Cox.tsv"
),
check.names=FALSE
)

cox <- subset(
cox,
Variable %in% c(
"Expression_Z",
"Mutation",
"age_at_index"
)
)

p <- ggplot(
cox,
aes(
x=HR,
y=reorder(Variable,HR)
)
)+
geom_point(size=3)+
geom_errorbarh(
aes(
xmin=Lower95,
xmax=Upper95
),
height=0.2
)+
geom_vline(
xintercept=1,
linetype=2
)+
labs(
title=paste(driver,"Multivariable Cox Model"),
x="Hazard Ratio",
y=""
)+
theme_bw()

ggsave(
file.path(
"results",
"evidence",
driver,
"Clinical",
"Forest_Plot.png"
),
p,
width=7,
height=4,
dpi=300
)

cat("Forest plot exported.\n")

}
