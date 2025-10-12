import numpy as np
import pandas as pd
from scipy.optimize import curve_fit

# --- 1. Data Setup (Using placeholder data) ---
data = {
    'gmp': [50000, 60000, 70000, 80000, 90000],
    'pcgmp': [5000, 6000, 7000, 8000, 9000]
}
gmp_df = pd.DataFrame(data)
gmp_df['pop'] = gmp_df['gmp'] / gmp_df['pcgmp']

# Extract variables
POP = gmp_df['pop'].to_numpy()
PCGMP = gmp_df['pcgmp'].to_numpy()

# --- 2. Define the Non-Linear Model Function ---
# Model: pcgmp ~ y0 * pop^a
def power_law_model(pop, y0, a):
    """
    Defines the power-law model: y0 * pop**a
    The first argument MUST be the independent variable (pop).
    """
    return y0 * (pop ** a)

# --- 3. Fit the Model (Non-Linear Least Squares) ---
# start=list(y0=5000, a=0.1) in R is the 'p0' argument here
p0 = [5000.0, 0.1] 

# curve_fit returns:
# p_opt: Optimal parameters (y0, a)
# p_cov: Covariance matrix of the estimated parameters
p_opt, p_cov = curve_fit(
    f=power_law_model, 
    xdata=POP, 
    ydata=PCGMP, 
    p0=p0
)

# --- 4. Display Results (Equivalent to summary(fit2)) ---
# Calculate standard errors (sqrt of the diagonal of the covariance matrix)
perr = np.sqrt(np.diag(p_cov))

print("--- NLS Model Fit (Python) ---")
print(f"Optimal Parameters:")
print(f"  y0 (Estimate): {p_opt[0]:.3e}")
print(f"  a (Estimate):  {p_opt[1]:.3e}")
print("-" * 25)
print(f"Standard Errors:")
print(f"  y0 (Std. Err.): {perr[0]:.3e}")
print(f"  a (Std. Err.):  {perr[1]:.3e}")