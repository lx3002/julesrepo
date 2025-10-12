gamma.est_MM <- function(x) {
  m <- mean(x); v <- var(x) 
  return(c(shape=m^2/v, scale=v/m))
}

# Test with example data
x <- c(1.2, 2.3, 1.7, 3.1, 2.8, 1.5, 2.9, 3.5, 2.1, 1.9)
result <- gamma.est_MM(x)
print(result)