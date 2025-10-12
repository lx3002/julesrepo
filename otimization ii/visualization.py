import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import minimize, curve_fit
from numdifftools import Gradient as grad

# --- SETUP: Data and Fits (Assumed from previous steps) ---
data = {
    'gmp': [50000, 60000, 70000, 80000, 90000],
    'pcgmp': [5000, 6000, 7000, 8000, 9000]
}
gmp_df = pd.DataFrame(data)
gmp_df['pop'] = gmp_df['gmp'] / gmp_df['pcgmp']
POP = gmp_df['pop'].to_numpy()
PCGMP = gmp_df['pcgmp'].to_numpy()

# Model Function (used by both fits implicitly)
def power_law_model(pop, y0, a):
    return y0 * (pop ** a)

# Placeholder fit results (based on placeholder data)
theta0 = np.array([5000.0, 0.15])
def mse_func(theta):
    theta1, theta2 = theta
    prediction = theta1 * (POP ** theta2)
    return np.mean((PCGMP - prediction)**2)
fit1 = minimize(fun=mse_func, x0=theta0, method='BFGS', jac=grad(mse_func)) # BFGS/optim fit result
p_opt, _ = curve_fit(power_law_model, xdata=POP, ydata=PCGMP, p0=theta0) # NLS fit result (fit2)
# -------------------------------------------------------------------

# 1. plot(pcgmp~pop,data=gmp)
plt.figure(figsize=(8, 5))
plt.scatter(POP, PCGMP, label='Observed Data', color='black', marker='o')
plt.xlabel('pop')
plt.ylabel('pcgmp')
plt.title('Non-Linear Model Fits')

# 2. pop.order <- order(gmp$pop) (Get indices to sort)
sort_idx = np.argsort(POP)

# --- Fit 2 (NLS) Plot ---
# 3. lines(gmp$pop[pop.order], fitted(fit2)[pop.order])
# Get fitted values for the NLS model (fit2)
pcgmp_pred_fit2 = power_law_model(POP, *p_opt)
# Plot the sorted x and y values
plt.plot(
    POP[sort_idx], 
    pcgmp_pred_fit2[sort_idx], 
    color='red', 
    linewidth=2, 
    label='Fit 2 (NLS)'
)

# --- Fit 1 (BFGS/optim) Plot ---
# 4. curve(fit1$par[1]*x^fit1$par[2], add=TRUE, lty="dashed", col="blue")
# Parameters are fit1.x[0] and fit1.x[1]
theta1, theta2 = fit1.x
# Generate a smooth set of x values for the curve
pop_range = np.linspace(POP.min(), POP.max(), 100)
pcgmp_pred_fit1 = theta1 * (pop_range ** theta2)
plt.plot(
    pop_range, 
    pcgmp_pred_fit1, 
    color='blue', 
    linestyle='--', 
    label='Fit 1 (BFGS/optim)'
)

plt.legend()
plt.grid(True, linestyle=':', alpha=0.6)
plt.show()