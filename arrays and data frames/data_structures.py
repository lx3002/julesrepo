import numpy as np
import pandas as pd

# ARRAYS
x = np.array([7, 8, 10, 45])
x_arr = np.reshape(x, (2, 2))
print("Array:\n", x_arr)
print("Shape:", x_arr.shape)
print("Is array:", isinstance(x_arr, np.ndarray))
print("Type of elements:", x_arr.dtype)
print("Access element [0,1]:", x_arr[0, 1])
print("Flattened index [2]:", x_arr.flat[2])
print("Column 2:", x_arr[:, 1])
print("Indices where x_arr > 9:", np.where(x_arr > 9))

y = -x
y_arr = np.reshape(y, (2, 2))
print("y_arr + x_arr =\n", y_arr + x_arr)
print("Row sums:", np.sum(x_arr, axis=1))

# DATA FRAMES
data = {
    "Population": [3615, 365, 2212, 2110, 21198],
    "Income": [3624, 6315, 4530, 3378, 5114],
    "Illiteracy": [2.1, 1.5, 1.8, 1.9, 1.1],
    "Life.Exp": [69.05, 69.31, 70.55, 70.66, 71.71],
    "HS.Grad": [41.3, 66.7, 58.1, 39.9, 62.6]
}
states = pd.DataFrame(data, index=["Alabama", "Alaska", "Arizona", "Arkansas", "California"])
print("\nDataFrame:\n", states)
print("\nAccessing row 'California':\n", states.loc["California"])
print("Illiteracy in 'California':", states.loc["California", "Illiteracy"])
print("\nHigh illiteracy states (>1.5):\n", states[states["Illiteracy"] > 1.5])

print("\nHS.Grad Summary (before):\n", states["HS.Grad"].describe())
states["HS.Grad"] = states["HS.Grad"] / 100
print("\nHS.Grad Summary (after division):\n", states["HS.Grad"].describe())
states["HS.Grad"] = 100 * states["HS.Grad"]
states["Literate_Grad_%"] = 100 * (states["HS.Grad"] / (100 - states["Illiteracy"]))
print("\nCalculated Literate Graduate %:\n", states["Literate_Grad_%"].head())

# EIGENVALUES AND EIGENVECTORS
factory = np.array([[35, 10], [8, 4]])
eig_values, eig_vectors = np.linalg.eig(factory)
print("\nEigenvalues:\n", eig_values)
print("Eigenvectors:\n", eig_vectors)
print("Second eigenvalue * vector:\n", eig_values[1] * eig_vectors[:, 1])

# ADDING ROWS AND COLUMNS
df = pd.DataFrame({"v1": [35, 8], "v2": [10, 4], "logicals": [True, False]})
print("\nDataFrame before adding row:\n", df)
df.loc[len(df)] = [-3, -5, True]
print("\nAfter adding a row:\n", df)

# DICTIONARIES (KEY–VALUE PAIRS)
plan = {
    "factory": factory,
    "available": {"labor": 40, "steel": 20},
    "output": {"trucks": 20, "cars": 10}
}
print("\nPlan Output:", plan["output"])
my_distribution = {"family": "exponential", "mean": 5, "rate": 1/5}
my_distribution["was_estimated"] = False
my_distribution["last_updated"] = "2011-08-30"
print("\nMy Distribution:", my_distribution)
del my_distribution["was_estimated"]
print("After removal:", my_distribution)
