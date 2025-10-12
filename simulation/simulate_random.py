import numpy as np
import matplotlib.pyplot as plt

# --- Binomial (manual) ---
def my_binom_1(n=1, p=1/3):
    u = np.random.rand(n)
    return np.sum(u < p)

print(my_binom_1(1000))
print(my_binom_1(1000, 0.5))

# --- Quantile Transform for Binomial ---
from scipy.stats import binom
def my_binom_2(n=1, p=1/3):
    u = np.random.rand()
    return binom.ppf(u, n, p)

print(my_binom_2(1000))
print(my_binom_2(1000, 0.5))

# --- Exponential via inverse CDF ---
u = np.random.rand(10000)
beta = 3
x = -beta * np.log(1 - u)
plt.hist(x, bins=30, color='lightblue')
plt.title("Exponential(β=3)")
plt.show()
print(np.mean(x))

# --- Gamma (accept-reject) ---
def ar_gamma(n=100):
    x = []
    while len(x) < n:
        u = np.random.rand()
        if u < 0.5:
            y = -np.log(1 - np.random.rand())
        else:
            y = -np.log(1 - np.random.rand()) - np.log(1 - np.random.rand())
        u2 = np.random.rand()
        temp = 2 * np.sqrt(y) / (1 + y)
        if u2 < temp:
            x.append(y)
    return np.array(x)

xg = ar_gamma(10000)
plt.hist(xg, bins=30, color='lightgreen')
plt.title("Gamma(3/2,1)")
plt.show()

print(np.mean(xg))

# --- Beta via rejection sampling ---
x1 = np.random.rand(300)
y1 = np.random.uniform(0, 2.6, 300)
from scipy.stats import beta
selected = y1 < beta.pdf(x1, 3, 6)
accepted = x1[selected]
plt.hist(accepted, bins=30, color='orange')
plt.title("Beta(3,6) via Rejection Sampling")
plt.show()

print(np.mean(selected))
print(np.mean(accepted < 0.5))
print(beta.cdf(0.5, 3, 6))

# --- Box–Muller Normal generation ---
u = np.random.rand(10000)
v = np.random.rand(10000)
r = np.sqrt(-2 * np.log(u))
theta = 2 * np.pi * v
x_norm = r * np.cos(theta)
plt.hist(x_norm, bins=40, color='skyblue')
plt.title("Box–Muller Normal(0,1)")
plt.show()
