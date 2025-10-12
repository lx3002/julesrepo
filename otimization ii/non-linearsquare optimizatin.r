gmp <- read.table("gmp.dat") 
gmp$pop <- gmp$gmp/gmp$pcgmp 
library(numDeriv) 
mse <- function(theta) { 
  mean((gmp$pcgmp - theta[1]*gmp$pop^theta[2])^2) 
  } 
grad.mse <- function(theta) { grad(func=mse,x=theta) } 
theta0=c(5000,0.15) 
fit1 <- optim(theta0,mse,grad.mse,method="BFGS",hessian=TRUE) 

print(paste("Convergence:", fit1$convergence))
print(paste("Message:", fit1$message))
print("Hessian Matrix:")
fit1$hessian