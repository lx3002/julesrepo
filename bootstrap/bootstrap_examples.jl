using Random, Distributions, StatsBase, Statistics, Plots, DataFrames, GLM

# --- Toy Collector Problem ---
prob_table = [.2, .1, .1, .1, .1, .1, .05, .05, .05, .05, .02, .02, .02, .02, .02]
boxes = 1:15

function box_count(prob=prob_table)
    collected = falses(length(prob))
    count = 0
    while sum(collected) < length(prob)
        x = sample(boxes, Weights(prob))
        collected[x] = true
        count += 1
    end
    return count
end

sim_boxes = [box_count() for _ in 1:1000]
histogram(sim_boxes, bins=30, title="Toy Collector Simulation", xlabel="Boxes")

# --- Bootstrap Example: Speed of Light ---
speed = [28, -44, 29, 30, 26, 27, 22, 23, 33, 16,
         24, 29, 24, 40, 21, 31, 34, -2, 25, 19]
newspeed = speed .- mean(speed) .+ 33.02

bstrap = [mean(sample(newspeed, 20, replace=true)) for _ in 1:1000]
histogram(bstrap, bins=30, title="Bootstrap Sampling Distribution", xlabel="Mean")

pval = (count(<(21.75), bstrap) + count(>(44.29), bstrap)) / 1000
println("P-value: ", pval)

# --- Bootstrap R² Example ---
df = dataset("datasets", "mtcars")
X = select(df, [:wt, :disp])
y = df.mpg

function bootstrap_rsq(X, y, n_boot=1000)
    rsq_vals = Float64[]
    for _ in 1:n_boot
        idx = sample(1:length(y), length(y), replace=true)
        model = lm(@formula(mpg ~ wt + disp), df[idx, :])
        push!(rsq_vals, r2(model))
    end
    return rsq_vals
end

rsq_vals = bootstrap_rsq(X, y)
histogram(rsq_vals, bins=30, title="Bootstrap R² (mpg~wt+disp)")
println("Mean R² = ", mean(rsq_vals))
