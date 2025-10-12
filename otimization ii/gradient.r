# numerical_gradient.R

gradient <- function(f, x, deriv.steps, ...) {
  p <- length(x)
  stopifnot(length(deriv.steps) == p)
  f.old <- f(x, ...)
  gradient <- vector(length = p)
  for (coordinate in 1:p) {
    x.new <- x
    x.new[coordinate] <- x.new[coordinate] + deriv.steps[coordinate]
    f.new <- f(x.new, ...)
    gradient[coordinate] <- (f.new - f.old) / deriv.steps[coordinate]
  }
  return(gradient)
}