using Distributions, Plots

# Define range
this_range = 0:0.05:8

# Create exponential distributions
dist1 = Exponential(1)      # rate = 1
dist2 = Exponential(0.5)    # rate = 0.5
dist3 = Exponential(0.2)    # rate = 0.2

# Plot them
plot(this_range, pdf.(dist1, this_range), label="rate=1", title="Exponential Distributions",
     xlabel="x", ylabel="f(x)")
plot!(this_range, pdf.(dist2, this_range), color="red", label="rate=0.5")
plot!(this_range, pdf.(dist3, this_range), color="blue", label="rate=0.2")
