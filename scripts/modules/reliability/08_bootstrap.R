bootstrap_statistics <- function(

x,

B=1000

){

x <- x[is.finite(x)]

means <- numeric(B)

medians <- numeric(B)

sds <- numeric(B)

for(i in seq_len(B)){

s <- sample(

x,

replace=TRUE

)

means[i] <- mean(s)

medians[i] <- median(s)

sds[i] <- sd(s)

}

list(

Mean=list(

Mean=mean(means),

SD=sd(means),

CI=quantile(means,c(0.025,0.975))

),

Median=list(

Mean=mean(medians),

SD=sd(medians),

CI=quantile(medians,c(0.025,0.975))

),

SD=list(

Mean=mean(sds),

SD=sd(sds),

CI=quantile(sds,c(0.025,0.975))

)

)

}
