this.range <- seq(0, 8, .05)
plot(this.range, dexp(this.range), ty="l", main="Exponential Distributions",
     xlab="x", ylab="f(x)")
lines(this.range, dexp(this.range, rate=0.5), col="red")
lines(this.range, dexp(this.range, rate=0.2), col="blue")
