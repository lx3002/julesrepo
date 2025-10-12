# Better implementation using a closure to avoid global state
create_random_generator <- function(initial_seed = 10, a = 5, c = 12, m = 16) {
    seed <- initial_seed
    function() {
        seed <<- (a * seed + c) %% m
        return(seed)
    }
}

# Usage
new.random <- create_random_generator()
out.length <- 20
variates <- numeric(out.length)
for (kk in 1:out.length) {
    variates[kk] <- new.random()
}

variates