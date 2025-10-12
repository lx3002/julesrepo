# optimization_factory.R

factory <- matrix(c(40,1,60,3), nrow=2,
  dimnames=list(c("labor","steel"), c("car","truck")))
available <- c(1600,70); names(available) <- rownames(factory)
prices <- c(car=13, truck=27)
revenue <- function(output) { return(-output %*% prices) }
plan <- constrOptim(theta=c(5,5), f=revenue, grad=NULL,
  ui=-factory, ci=-available, method="Nelder-Mead")
plan$par