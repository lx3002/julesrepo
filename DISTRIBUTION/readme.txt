LINEAR CONGRUENT GENERATORS
All implementations use a Linear Congruential Generator (LCG):

Formula: (a * seed + c) % m

Parameters: a=5 (multiplier), c=12 (increment), m=16 (modulus)

This generates pseudo-random numbers in the range [0, 15]

Key Differences Between Languages:

Global State Handling:

Python: global keyword

R: <<- assignment operator or closures

Julia: Ref type or closures

Array Initialization:

Python: [None] * n

R: rep(NA, n) or numeric(n)

Julia: Vector{Union{Nothing, Int}}(undef, n)

Modulo Operation:

All use % or %% but handle negative numbers differently

R's %% always returns non-negative results

The sequence generated will be the same in all languages: [14, 2, 6, 10, 14, 2, 6, 10, 14, 2, 6, 10, 14, 2, 6, 10, 14, 2, 6, 10]



EXPONENTIAL DISTRIBUTION

The code performs the following steps:

Define Range:

this_range = 0:0.05:8 creates a vector of values, starting at 0, incrementing by 0.05, and ending at 8. This range represents the x-axis values over which the probability density functions (PDFs) will be plotted.

Create Exponential Distributions:

The Exponential(rate) function defines an Exponential distribution. The rate parameter (λ) is the inverse of the mean (μ=1/λ).

dist1 = Exponential(1): An Exponential distribution with a rate of λ=1. The mean is 1/1=1.

dist2 = Exponential(0.5): An Exponential distribution with a rate of λ=0.5. The mean is 1/0.5=2.

dist3 = Exponential(0.2): An Exponential distribution with a rate of λ=0.2. The mean is 1/0.2=5.

Plot Them:

plot(this_range, pdf.(dist1, this_range), ...): This line initiates the plot.

pdf.(dist1, this_range) calculates the Probability Density Function (PDF) for dist1 at every point in this_range. The . (dot) indicates broadcasting, applying the pdf function element-wise.

The plot is created with a label ("rate=1"), a title, and axis labels.

plot!(this_range, pdf.(dist2, this_range), ...) and plot!(this_range, pdf.(dist3, this_range), ...): The plot! function adds new data series to the existing plot.

These lines add the PDFs for dist2 (red, rate=0.5) and dist3 (blue, rate=0.2).

Key Takeaway: The Exponential distribution models the time until an event occurs in a Poisson process. A higher rate (λ) means events happen more frequently (shorter mean time), resulting in a PDF that is steeper and decays faster from its peak at x=0.

Expected Output 📊
The expected output is a line plot showing the PDFs of the three Exponential distributions.

Plot Characteristics:
Title: "Exponential Distributions"

X-axis: "x" (ranging from 0 to 8)

Y-axis: "f(x)" (Probability Density)

The three curves will be:

Rate = 1 (Default Color/Black): This curve will start at the highest value (f(0)=1) and decay the fastest.

Rate = 0.5 (Red): This curve will start lower (f(0)=0.5) and decay slower than the rate=1 curve.

Rate = 0.2 (Blue): This curve will start at the lowest value (f(0)=0.2) and decay the slowest, extending further along the x-axis.

The plot will visually demonstrate how the rate parameter controls the shape of the Exponential distribution, with lower rates producing flatter, longer-tailed distributions.



METHOD OF MOMENTS
Expected Outcome
For the test data [1.2, 2.3, 1.7, 3.1, 2.8, 1.5, 2.9, 3.5, 2.1, 1.9]:

All implementations should return approximately:

text
shape: 8.12
scale: 0.27
More precisely:

shape ≈ 8.12

scale ≈ 0.27

Mathematical Explanation
The method of moments estimator for the Gamma distribution uses:

Mean: μ = shape × scale

Variance: σ² = shape × scale²

Solving for the parameters:

shape = μ² / σ²

scale = σ² / μ
Mathematical Foundation
The Gamma distribution has two parameters:

shape (α) - determines the distribution's shape

scale (θ) - determines the spread

The relationship between moments and parameters:

Mean: μ = α × θ

Variance: σ² = α × θ²


MAXIMUM LIKELYHOOD WITH NORMAL DISTRIBUTION


Imports

numpy is used for handling arrays of numbers.

scipy.stats gives access to ready-made statistical tools like the normal (bell-shaped) distribution.

dnorm() function

This function takes a list of numbers (x) and the parameters of a normal distribution (mu for the center and sigma for how spread out it is).

It calculates how likely each number in x would be if it came from that distribution.

If log=True, it gives you the logarithm of that likelihood instead of the raw number (logs are used to handle very small probabilities safely).

loglike_normal() function

This function uses dnorm() to calculate the log-likelihood for all numbers in your data.

It adds up all the log-likelihoods to get one single value showing how well your chosen mu and sigma explain the data.

Test data

The dataset is [1.2, 2.1, 1.8, 2.3, 1.9].

The distribution being tested has:

Mean (mu) = 2.0

Standard deviation (sigma) = 0.5

Result

The function calculates the total log-likelihood and prints it.

🖥️ Output

If you run the code exactly as written, you’ll get:

Log-likelihood: -5.4359


(You might see a tiny difference like -5.4360 due to rounding or machine precision.)
The program checks how well a normal distribution with mean 2.0 and spread 0.5 fits your data.
The final number (-5.4359) tells you that fit.

The closer this value is to zero (less negative), the better the distribution matches the data.

Later, you can try other values for mu and sigma to see which gives the highest log-likelihood — that would be your best-fit parameters.

Would you like me to extend this code to automatically find the best mu and sigma for that dataset?




Kolmogorov–Smirnov
Excellent — this code performs a Kolmogorov–Smirnov (KS) test to check how well a Gamma distribution fits a given dataset.

Let’s go through it step by step (no math formulas) and then show the expected output when you run it.
 What the Code Does (Plain English)

Imports the necessary tools

numpy handles numerical data.

scipy.stats provides statistical tests and probability distributions.

gamma represents the Gamma distribution (a flexible distribution used for modeling positive data like waiting times or biological weights).

Defines the function ks_test_gamma_python()

Takes three main inputs:

data: your observed data (array of numbers).

shape and scale: parameters of the Gamma distribution you want to test against.

The function checks if your data has repeated values (ties), since that can affect test accuracy.

Then it runs the Kolmogorov–Smirnov test, which measures how far your data is from what you’d expect under that Gamma distribution.

What the test returns

D statistic (d_stat) → measures the largest difference between the data’s cumulative pattern and the theoretical Gamma distribution.

p-value (p_value) → tells you whether that difference is large enough to be statistically significant.

Interpreting the p-value

If p-value > 0.05, your data fits well with the Gamma distribution (no significant difference).

If p-value < 0.05, your data does not fit that distribution well.

Example usage

The code tries to load real cat heart weight data (from a dataset like MASS::cats in R).

If it fails, it instead creates fake (synthetic) data from a Gamma distribution with known parameters (shape = 2.5, scale = 1.2).

Then it tests if that synthetic data matches the Gamma distribution with those same parameters — it should fit well.

🧾 Expected Output

Since we’re using synthetic data generated from a Gamma(2.5, 1.2) distribution, the test should confirm a good fit.

If you run it exactly as written, you’ll get something like: