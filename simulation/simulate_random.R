# ==============================
# RANDOM VARIATE SIMULATION IN R
# ==============================

# --- Binomial Simulation (Manual) ---
my.binom.1 <- function(n=1, p=1/3){
  u <- runif(n)
  binom <- sum(u < p)
  return(binom)
}
print(my.binom.1(1000))
print(my.binom.1(1000, .5))

# --- Binomial using Quantile Transform ---
my.binom.2 <- function(n=1, p=1/3){
  u <- runif(1)
  binom <- qbinom(u, size=n, prob=p)
  return(binom)
}
print(my.binom.2(1000))
print(my.binom.2(1000, .5))

# --- Exponential Simulation using Inverse CDF ---
x <- runif(10000)
beta <- 3
y <- -beta * log(1 - x)
hist(y, main="Simulated Exponential(β=3)", col="lightblue", breaks=30)
print(mean(y))

# Compare with theoretical curve
true.x <- seq(0, 30, .5)
true.y <- dexp(true.x, 1/beta)
hist(y, freq=F, breaks=30, main="Exp(β=3) vs Theoretical", col="lightgray")
points(true.x, true.y, type="l", col="red", lwd=2)

# --- Gamma Simulation (Accept-Reject) ---
ar.gamma <- function(n=100){
  x <- double(n)
  i <- 1
  while(i < (n + 1)){
    u <- runif(1)
    if(u < 0.5){
      y <- -log(1 - runif(1))
    } else {
      y <- sum(-log(1 - runif(2)))
    }
    u <- runif(1)
    temp <- 2 * sqrt(y) / (1 + y)
    if(u < temp){
      x[i] <- y
      i <- i + 1
    }
  }
  return(x)
}

x <- ar.gamma(10000)
hist(x, main="Simulated Gamma(3/2,1)", col="lightgreen", breaks=30)
print(mean(x))

true.x <- seq(0,10,.1)
true.y <- dgamma(true.x, 3/2, 1)
hist(x, freq=F, breaks=30, col="lightgray", xlab="x", main="Gamma(3/2,1) vs Theory")
points(true.x, true.y, type="l", col="red", lwd=2)

# --- Beta Distribution (Rejection Sampling) ---
x1 <- runif(300, 0, 1)
y1 <- runif(300, 0, 2.6)
selected <- y1 < dbeta(x1, 3, 6)
accepted.points <- x1[selected]
hist(accepted.points, main="Beta(3,6) via Rejection Sampling", col="orange")

print(mean(selected))
print(mean(accepted.points < 0.5))
print(pbeta(0.5, 3, 6))

# --- Box-Muller Normal Generation ---
u <- runif(10000)
v <- runif(10000)
r <- sqrt(-2 * log(u))
theta <- 2 * pi * v
x_norm <- r * cos(theta)
y_norm <- r * sin(theta)
hist(x_norm, main="Box-Muller Normal(0,1)", col="lightblue", breaks=40)
