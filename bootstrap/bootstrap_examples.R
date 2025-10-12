# =============================
# BOOTSTRAP AND RESAMPLING IN R
# =============================

# --- Toy Collector Problem ---
prob.table <- c(.2, .1, .1, .1, .1, .1, .05, .05, .05, .05, .02, .02, .02, .02, .02)
boxes <- seq(1, 15)

box.count <- function(prob = prob.table) {
  check <- double(length(prob))
  i <- 0
  while(sum(check) < length(prob)) {
    x <- sample(boxes, 1, prob = prob)
    check[x] <- 1
    i <- i + 1
  }
  return(i)
}

# Monte Carlo Simulation
trials <- 1000
sim.boxes <- double(trials)
for(i in 1:trials){
  sim.boxes[i] <- box.count()
}

# Estimate mean, SE, 95% CI
est <- mean(sim.boxes)
mcse <- sd(sim.boxes) / sqrt(trials)
interval <- est + c(-1,1) * 1.96 * mcse

cat("Estimated Mean Boxes:", est, "\n")
cat("95% CI:", interval, "\n")

hist(sim.boxes, main="Histogram of Total Boxes", xlab="Boxes", col="lightblue")
abline(v=c(300, 500, 800), col=c("red","green","orange"), lwd=2)


# --- Bootstrap Concept (Plug-in Principle) ---
# (Illustrative — see notes for theory)

# --- Abnormal Speed of Light Example ---
speed <- c(28, -44, 29, 30, 26, 27, 22, 23, 33, 16,
           24, 29, 24, 40, 21, 31, 34, -2, 25, 19)
mean(speed)

# Shifted data to enforce null mean = 33.02
newspeed <- speed - mean(speed) + 33.02
hist(newspeed, main="Shifted Speed Data (Null True)", col="lightgray")

# Bootstrap sampling distribution
n <- 1000
bstrap <- double(n)
for (i in 1:n){ 
  newsample <- sample(newspeed, 20, replace=TRUE)
  bstrap[i] <- mean(newsample)
}

hist(bstrap, main="Bootstrap Sampling Distribution", col="lightblue")
abline(v=33.02, col="red", lwd=2)
abline(v=21.75, col="darkgreen", lwd=2)

# Compute p-value
p_value <- (sum(bstrap < 21.75) + sum(bstrap > 44.29)) / n
cat("P-value:", p_value, "\n")
if (p_value < 0.05) cat("Reject H0: data not consistent with mean=33.02\n")

# --- Sleep Study Example (Bootstrap Difference in Means) ---
bootstrap.resample <- function(object) sample(object, length(object), replace=TRUE)
diff.in.means <- function(df) {
  mean(df[df$group==1,"extra"]) - mean(df[df$group==2,"extra"])
}
data(sleep)
resample.diffs <- replicate(2000, diff.in.means(sleep[bootstrap.resample(1:nrow(sleep)),]))
hist(resample.diffs, main="Bootstrap Sampling Distribution (Sleep Study)", col="lightgreen")
abline(v=diff.in.means(sleep), col="red", lwd=2)

# --- Bootstrapping with the 'boot' Package ---
library(boot)
data(city)

# Example: Ratio of means
ratio <- function(d, w) sum(d$x * w)/sum(d$u * w)
results <- boot(city, ratio, R=1000, stype="w")
print(results)
boot.ci(results, type="bca")

# --- Bootstrapping a Regression Statistic (R-squared) ---
rsq <- function(formula, data, indices) {
  d <- data[indices,]
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
}
results2 <- boot(data=mtcars, statistic=rsq, R=1000, formula=mpg~wt+disp)
print(results2)
boot.ci(results2, type="bca")
plot(results2, main="Bootstrap R² for mpg~wt+disp")
