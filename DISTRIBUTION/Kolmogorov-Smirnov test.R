# Original R code
ks.test(cats$Hwt, pgamma, shape=cats.gamma["shape"], scale=cats.gamma["scale"])

# Enhanced R version with better output handling
result <- ks.test(cats$Hwt, pgamma, shape=cats.gamma["shape"], scale=cats.gamma["scale"])
print(result)

# Check for ties explicitly
if(any(duplicated(cats$Hwt))) {
  warning("Ties should not be present for the Kolmogorov-Smirnov test")
}