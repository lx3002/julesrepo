# 1. lp_data_definition

# Factory matrix: Rows are resources (labor, steel), Cols are products (car, truck)
factory <- matrix(c(40,1,60,3),nrow=2,
  dimnames=list(c("labor","steel"),c("car","truck")))

# Available resources
available <- c(labor=1600, steel=70)

# Revenue per unit (to be maximized)
prices <- c(car=13,truck=27)

# Objective function: MINIMIZE the NEGATIVE revenue
revenue <- function(output) { 
  # output is a vector [car, truck]
  return(-output %*% prices) 
}

# The problem is structured as: Minimize f(output) subject to ui * output >= ci
# Constraint: factory * output <= available 
# Equivalent to: -factory * output >= -available

# 2. r_original_constrained

# Nelder-Mead optimization for constrained function
# Note: This general solver can be less efficient than a dedicated LP solver.
plan <- constrOptim(
  theta=c(5,5),      # Initial guess for [car, truck]
  f=revenue,         # Function to minimize (negative revenue)
  grad=NULL,         # Nelder-Mead does not require a gradient
  ui=-factory,       # Constraint matrix A (left side of A*x >= b)
  ci=-available,     # Constraint vector b (right side of A*x >= b)
  method="Nelder-Mead"
)

print("--- R constrOptim Results ---")
print("Optimal Production Plan (car, truck):")
# plan$par holds the optimal quantities
plan$par 