using DataFrames, CSV, Optim, ForwardDiff, LinearAlgebra

# --- 1. Load Data (REPLACE THIS WITH YOUR ACTUAL DATA LOADING) ---
# NOTE: Julia is column-major, so DataFrames work similarly to R
# We'll create a dummy file to read, as the file itself wasn't provided.
data = DataFrame(gmp = [50000.0, 60000.0, 70000.0, 80000.0, 90000.0],
                 pcgmp = [5000.0, 6000.0, 7000.0, 8000.0, 9000.0])
# Dummy file creation is removed, but this is the dataframe structure you'd want.

# Calculate the 'pop' column, equivalent to gmp$pop <- gmp$gmp/gmp$pcgmp
data[!, :pop] = data.gmp ./ data.pcgmp

# Extract variables as vectors
const PCGMP = data.pcgmp
const POP = data.pop

# --- 2. Define the Objective Function (Mean Squared Error) ---
# The R-like function: mse <- function(theta) { mean((gmp$pcgmp - theta[1]*gmp$pop^theta[2])^2) }
# We use a mutable vector `x` for the parameters (theta)
function mse(x)
    θ₁ = x[1]
    θ₂ = x[2]
    # Prediction: θ₁ * POP.^θ₂
    prediction = θ₁ .* (POP .^ θ₂)
    # Mean Squared Error: mean((PCGMP - prediction).^2)
    return mean((PCGMP .- prediction).^2)
end

# --- 3. Define the Objective Function with Gradient and Hessian ---
# In Julia, we can use an Optim.jl helper to generate the required structure
# for the optimization algorithm, using automatic differentiation (AD) for speed.

# Create the Optimization.jl objective structure
# This automatically creates the gradient and Hessian functions for `mse`
objective = TwiceDifferentiable(mse, [5000.0, 0.15]; autodiff = :forward);

# --- 4. Optimization ---
# Initial guess for parameters: theta0=c(5000,0.15)
theta0 = [5000.0, 0.15]

# Run the optimization
# The BFGS method is the default in Optim.jl when a TwiceDifferentiable 
# objective is provided.
fit1 = optimize(objective, theta0, BFGS(), Optim.Options(
    g_tol = 1e-6, # Gradient convergence tolerance
    show_trace = true, # Display optimization trace
    extended_trace = true # Get more info like Hessian
    )
)

# Extract and display the Hessian (equivalent to R's `hessian=TRUE`)
final_hessian = Optim.hessian(fit1)

println("\n--- Optimization Results (Julia) ---")
println(fit1)
println("\nFinal Hessian Matrix:")
display(final_hessian)