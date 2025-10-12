# --- SETUP: Data and Fits (Assumed from previous steps) ---
gmp <- data.frame(
    gmp = c(50000, 60000, 70000, 80000, 90000),
    pcgmp = c(5000, 6000, 7000, 8000, 9000)
)
gmp$pop <- gmp$gmp / gmp$pcgmp 
library(numDeriv) 
mse <- function(theta) { 
  mean((gmp$pcgmp - theta[1]*gmp$pop^theta[2])^2) 
} 
grad.mse <- function(theta) { grad(func=mse,x=theta) } 
theta0=c(5000,0.15) 
fit1 <- optim(theta0,mse,grad.mse,method="BFGS",hessian=TRUE) # BFGS fit
fit2 <- nls(pcgmp~y0*pop^a,data=gmp,start=list(y0=5000,a=0.1)) # NLS fit
# -------------------------------------------------------------------

# 1. Plot the raw data
plot(pcgmp~pop,data=gmp, 
     main="Comparison of NLS and BFGS Fits",
     col="black", 
     pch=19)

# 2. Get the sort order for 'pop'
pop.order <- order(gmp$pop) 

# 3. Plot the NLS (fit2) line
lines(gmp$pop[pop.order], 
      fitted(fit2)[pop.order],
      col="red",
      lwd=2)

# 4. Plot the BFGS (fit1) curve
curve(fit1$par[1]*x^fit1$par[2],
      add=TRUE,           # Overlay on current plot
      lty="dashed",       # Line type: dashed
      col="blue",         # Line color: blue
      lwd=2)              # Line width

# Add a legend
legend("topleft", 
       legend=c("Raw Data", "Fit 2 (NLS)", "Fit 1 (BFGS/optim)"),
       col=c("black", "red", "blue"),
       lty=c(NA, "solid", "dashed"),
       pch=c(19, NA, NA))