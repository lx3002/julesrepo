import numpy as np
from scipy.optimize import linprog

# 1. lp_data_definition

# Factory matrix: Rows = Resources (Labor, Steel), Cols = Products (Car, Truck)
# Constraint matrix A for A*x <= b
A_ub = np.array([
    [40, 60],  # Labor consumption per Car/Truck
    [ 1,  3]   # Steel consumption per Car/Truck
])

# Available resources (b)
b_ub = np.array([1600, 70]) # [Labor available, Steel available]

# Prices (c): Revenue per unit. The objective is to MAXIMIZE this.
prices = np.array([13, 27])

# 2. py_linear_programming 

# Standard LP form: Minimize c.T * x subject to A_ub * x <= b_ub
# We want to MAXIMIZE revenue, so we MINIMIZE the NEGATIVE revenue.
c = -prices 

# Bounds: Non-negativity constraints (car >= 0, truck >= 0)
bounds = [(0, None), (0, None)] # None means no upper bound

# Run the Linear Programming optimization
plan = linprog(
    c=c,            # Coefficients of the objective function (for minimization)
    A_ub=A_ub,      # Constraint matrix (A*x <= b)
    b_ub=b_ub,      # Constraint vector
    bounds=bounds,  # Non-negativity bounds
    method='highs'  # Modern, fast solver
)

print("--- Python Linear Programming Results (linprog) ---")
print("Optimization successful:", plan.success)
print("Optimal Production Plan (car, truck):")
# plan.x is the optimal output vector
print(plan.x)
print(f"Maximum Revenue: ${-plan.fun:.2f}") 
