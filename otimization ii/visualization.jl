using DataFrames, Plots, Optim, LsqFit, Random, NumericalIntegration

# --- SETUP: Data and Fits (Assumed from previous steps) ---
data = DataFrame(
    gmp = [50000.0, 60000.0, 70000.0, 80000.0, 90000.0],
    pcgmp = [5000.0, 6000.0, 7000.0, 8000.0, 9000.0]
)
data[!, :pop] = data.gmp ./ data.pcgmp
const POP = data.pop
const PCGMP = data.pcgmp

# Model Function
function power_law_model_lsq(pop, p)
    return p[1] .* (pop .^ p[2])
end

# Objective Function for Optim.jl
function mse_func_optim(x)
    θ₁ = x[1]
    θ₂ = x[2]
    prediction = θ₁ .* (POP .^ θ₂)
    return mean((PCGMP .- prediction).^2)
end

theta0 = [5000.0, 0.1]
# Fit 1 (BFGS/optim) result
fit1 = optimize(mse_func_optim, theta0, BFGS()) 
# Fit 2 (NLS/LsqFit) result
fit2 = curve_fit(power_law_model_lsq, POP, PCGMP, theta0)
# -------------------------------------------------------------------

# 1. plot(pcgmp~pop,data=gmp)
# Create a scatter plot of the raw data
p = plot(POP, PCGMP, 
    seriestype=:scatter, 
    label="Observed Data", 
    xlabel="pop", 
    ylabel="pcgmp", 
    title="Non-Linear Model Fits",
    legend=:topleft
)

# 2. pop.order <- order(gmp$pop) (Sorting is handled internally by plot! or explicit line below)

# --- Fit 2 (NLS) Plot ---
# 3. lines(gmp$pop[pop.order], fitted(fit2)[pop.order])
pcgmp_pred_fit2 = power_law_model_lsq(POP, fit2.param)
sort_idx = sortperm(POP)
plot!(p, POP[sort_idx], pcgmp_pred_fit2[sort_idx], 
    linewidth=2, 
    color=:red, 
    label="Fit 2 (NLS)")

# --- Fit 1 (BFGS/optim) Plot ---
# 4. curve(fit1$par[1]*x^fit1$par[2], add=TRUE, lty="dashed", col="blue")
# Define the function using the optimized parameters from fit1
fit1_model(x) = fit1.minimizer[1] * x^fit1.minimizer[2]

# Plot the function over the range of POP
plot!(p, fit1_model, minimum(POP), maximum(POP), 
    line=(:dash, 2, :blue), # lty="dashed", col="blue"
    label="Fit 1 (BFGS/optim)")

display(p)