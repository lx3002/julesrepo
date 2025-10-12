# ARRAYS
x <- c(7, 8, 10, 45)
x.arr <- array(x, dim=c(2,2))
print(x.arr)
print(dim(x.arr))
print(is.vector(x.arr))
print(is.array(x.arr))
print(typeof(x.arr))
str(x.arr)
print(attributes(x.arr))
print(x.arr[1,2])
print(x.arr[3])
print(x.arr[,2])
print(which(x.arr > 9))
y <- -x
y.arr <- array(y, dim=c(2,2))
print(y.arr + x.arr)
print(rowSums(x.arr))

# DATA FRAMES
library(datasets)
states <- data.frame(state.x77, abb=state.abb, region=state.region, division=state.division)
print(head(states))
print(colnames(states))
print(states["Wisconsin",])
print(states["Wisconsin","Illiteracy"])
print(states[49,3])
print(states[states$division=="New England","Illiteracy"])
print(states[states$region=="South","Illiteracy"])
print(summary(states$HS.Grad))
states$HS.Grad <- states$HS.Grad/100
print(summary(states$HS.Grad))
states$HS.Grad <- 100*states$HS.Grad
print(with(states, head(100*(HS.Grad/(100-Illiteracy)))))

# EIGENVALUES
factory <- matrix(c(35,10,8,4), nrow=2, byrow=TRUE)
eig <- eigen(factory)
print(eig)
print(class(eig))
print(factory %*% eig$vectors[,2])
print(eig$values[2]*eig$vectors[,2])

# ADDING ROWS AND COLUMNS
a.data.frame <- data.frame(v1=c(35,8), v2=c(10,4), logicals=c(TRUE,FALSE))
print(rbind(a.data.frame, list(v1=-3,v2=-5,logicals=TRUE)))

# LISTS
plan <- list(factory=factory, available=c(labor=40, steel=20), output=c(trucks=20, cars=10))
print(plan$output)
my.distribution <- list(family="exponential", mean=5, rate=1/5)
my.distribution$was.estimated <- FALSE
my.distribution[["last.updated"]] <- "2011-08-30"
my.distribution$was.estimated <- NULL
print(my.distribution)
