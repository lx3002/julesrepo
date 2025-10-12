# linear_regression_mse.R

x <- matrix(rnorm(200), nrow=100)
y <- (x %*% c(2,1)) + rnorm(100, sd=0.05)
mse <- function(b1,b2) {mean((y - x %*% c(b1,b2))^2)}
coef.seq <- seq(from=-1, to=5, length.out=200)
m <- outer(coef.seq, coef.seq, Vectorize(mse))
l1 <- function(b1,b2) {abs(b1) + abs(b2)}
l1.levels <- outer(coef.seq, coef.seq, l1)
ols.coefs <- coefficients(lm(y ~ 0 + x))