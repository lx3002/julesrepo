import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import expon

# Range of x values
this_range = np.arange(0, 8, 0.05)

# Plot exponential PDFs with different rates (λ)
plt.plot(this_range, expon.pdf(this_range, scale=1/1), label='rate=1')
plt.plot(this_range, expon.pdf(this_range, scale=1/0.5), 'r', label='rate=0.5')
plt.plot(this_range, expon.pdf(this_range, scale=1/0.2), 'b', label='rate=0.2')

plt.title("Exponential Distributions")
plt.xlabel("x")
plt.ylabel("f(x)")
plt.legend()
plt.grid(True)
plt.show()
