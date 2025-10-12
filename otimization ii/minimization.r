# --- 1. Data Setup (Using placeholder data) ---
gmp_data <- data.frame(
    gmp = c(50000, 60000, 70000, 80000, 90000),
    pcgmp = c(5000, 6000, 7000, 8000, 9000)
)
# Rename to 'gmp' to match the original code
gmp <- gmp_data

# Calculate the 'pop' column
gmp$pop <- gmp$gmp / gmp$pcgmp 

# --- 2. Fit the Non-Linear Model (NLS) ---
# Model: pcgmp ~ y0 * pop^a
# The 'nls' function uses the Gauss-Newton algorithm by default
fit2 <- nls(
    formula = pcgmp ~ y0 * pop^a,
    data = gmp,
    start = list(y0 = 5000, a = 0.1) # Initial guess for parameters
)

# --- 3. Display Summary ---
summary(fit2)