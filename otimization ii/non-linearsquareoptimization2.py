import numpy as np
import pandas as pd
from scipy.optimize import minimize
from numdifftools import Gradient as grad

# --- 1. Load Data (REPLACE THIS WITH YOUR ACTUAL DATA LOADING) ---
# Create placeholder data for demonstration
data = {
    'gmp': [50000, 60000, 70000, 80000, 90000],
    'pcgmp': [5000, 6000, 7000, 8000, 9000]
}
gmp_df = pd.DataFrame(data)

# Calculate the 'pop' column, equivalent to gmp$pop <- gmp$gmp/gmp$pcgmp
gmp_df['pop'] = gmp_df['gmp'] / gmp_df['pcgmp']

# Extract variables as numpy arrays for efficient computation
PCGMP = gmp_df['pcgmp'].to_numpy()
POP = gmp_df['pop'].to_numpy()
N = len(PCGMP)

# --- 2. Define the Objective Function (Mean Squared Error) ---
# The function to be minimized
def mse_func(theta):
    """
    Calculates the Mean Squared Error (MSE) between the observed pcgmp 
    and the non-linear model: theta[0] * pop**theta[1]
    theta is a numpy array: [theta1, theta2]
    """
    theta1, theta2 = theta
    # Model prediction
    prediction = theta1 * (POP ** theta2)
    # MSE calculation
    return np.mean((PCGMP - prediction)**2)

# --- 3. Define the Gradient Function (Analytical or Numerical) ---
# The R code uses an *external* numDeriv package to compute the gradient numerically.
# We will use the 'numdifftools' library, which is the Python equivalent.
grad_mse_func = grad(mse_func)

# --- 4. Optimization ---
# Initial guess for parameters: theta0=c(5000,0.15)
theta0 = np.array([5000.0, 0.15])

# Run the optimization
# `jac=grad_mse_func` provides the gradient (Jacobian) to the optimizer
fit1 = minimize(
    fun=mse_func, 
    x0=theta0, 
    method='BFGS', 
    jac=grad_mse_func, # Use the numerical gradient from numdifftools
    options={'disp': True, 'hess': True} # 'hess': True is for returning the final Hessian
)

print("\n--- Optimization Results (Python) ---")
print(f"Optimal parameters (theta): {fit1.x}")
print(f"Minimum MSE value: {fit1.fun}")
print(f"Convergence status: {fit1.message}")
print(f"Final Hessian Matrix:\n{fit1.hess}")


print(f"Convergence Status (0 is success): {fit1.status}") 
# R '0' maps to Python status '0' (success)
print(f"Message: {fit1.message}")
print(f"Hessian Matrix:\n{fit1.hess}")