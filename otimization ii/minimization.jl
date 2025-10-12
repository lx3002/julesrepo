using DataFrames, LsqFit, Printf

# --- 1. Data Setup (Using placeholder data) ---
data = DataFrame(
    gmp = [50000.0, 60000.0, 70000.0, 80000.0, 90000.0],
    pcgmp = [5000.0, 6000.0, 7000.0, 8000.0, 9000.0]
)
data[!, :pop] = data.gmp ./ data.pcgmp

# Extract variables
const POP = data.pop
const PCGMP = data.pcgmp

# --- 2. Define the Non-Linear Model Function ---
# The function must take the independent variable(s) 'pop' and the parameters 'p'
# Model: pcgmp ~ y0 * pop^a. Parameters p[1] = y0, p[2] = a
function power_law_model(pop, p)
    # Element-wise power-law: p[1] * pop.^p[2]
    return p[1] .* (pop .^ p[2])
end

# --- 3. Fit the Model (Non-Linear Least Squares) ---
# Initial guess p0: [y0, a]
p0 = [5000.0, 0.1]

# Fit the model using LsqFit.levenberg_marquardt (default)
# The convergence information is similar to R's `nls` output
fit2 = curve_fit(power_law_model, POP, PCGMP, p0)

# --- 4. Display Results (Equivalent to summary(fit2)) ---
# LsqFit has a summary function that provides most of the required statistics
model_summary = confidence_interval(fit2, 0.95)

@printf "--- NLS Model Fit (Julia) ---\n"
@printf "Achieved convergence tolerance: %.3e\n" fit2.converged
@printf "Number of iterations: %d\n\n" fit2.iterations

# LsqFit does not provide the 't-value' and 'Pr(>|t|)' directly,
# but gives the parameter estimates and confidence intervals (derived from standard errors).
@printf "Parameters:\n"
@printf "           Estimate   95%% Lower   95%% Upper\n"
@printf "y0 (%s):  %10.3e %10.3e %10.3e\n" "p[1]" fit2.param[1] model_summary[1][1] model_summary[1][2]
@printf "a  (%s):  %10.3e %10.3e %10.3e\n" "p[2]" fit2.param[2] model_summary[2][1] model_summary[2][2]