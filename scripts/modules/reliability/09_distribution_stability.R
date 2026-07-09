distribution_stability <- function(

boot,

observed

){

list(

Bias=

boot$Mean$Mean-

observed,

Precision=

boot$Mean$SD,

CIWidth=

diff(

boot$Mean$CI

)

)

}
