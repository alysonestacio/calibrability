# Geometric and auxiliary functions

# Function to calculate the distance between a point and a line (2D)
# Point: P(x0, y0), Line: ax + by + c = 0
point_line_distance <- function(x0, y0, a = 1, b = -1, c = 0) {
  distance <- abs(a * x0 + b * y0 + c) / sqrt(a^2 + b^2)
  return(distance)
}

# Function to fit an orthogonal regression line
# Equation: y = a * x
orthogonal_regression <- function(x, y) {
  # Define the optimization function
  optimize_fn <- function(a) {
    distances <- point_line_distance(x, y, a = a, b = -1, c = 0)
    sum(distances^2) # Minimize the sum of squared distances
  }
  
  # Perform optimization
  result <- optim(par = 1, fn = optimize_fn, method = "Brent", lower = -10^6, upper = 10^6)
  return(result)
}

# Function to compute the cross product of two 3D vectors
cross_product_3d <- function(vec1, vec2) {
  x <- vec1[2] * vec2[3] - vec1[3] * vec2[2]
  y <- vec1[3] * vec2[1] - vec1[1] * vec2[3]
  z <- vec1[1] * vec2[2] - vec1[2] * vec2[1]
  return(c(x, y, z))
}

# Function to compute a 3D rotation matrix
# Inputs: vec_norm (rotation axis), ang (rotation angle in radians)
rotation_matrix_3d <- function(vec_norm, ang) {
  a <- vec_norm[1]
  b <- vec_norm[2]
  c <- vec_norm[3]
  
  # Define the rotation matrix
  rot_matrix <- matrix(NA, 3, 3)
  rot_matrix[1, 1] <- cos(ang) + (1 - cos(ang)) * a^2
  rot_matrix[2, 2] <- cos(ang) + (1 - cos(ang)) * b^2
  rot_matrix[3, 3] <- cos(ang) + (1 - cos(ang)) * c^2
  rot_matrix[1, 2] <- (1 - cos(ang)) * a * b + sin(ang) * c
  rot_matrix[1, 3] <- (1 - cos(ang)) * a * c - sin(ang) * b
  rot_matrix[2, 1] <- (1 - cos(ang)) * b * a - sin(ang) * c
  rot_matrix[2, 3] <- (1 - cos(ang)) * b * c + sin(ang) * a
  rot_matrix[3, 1] <- (1 - cos(ang)) * c * a + sin(ang) * b
  rot_matrix[3, 2] <- (1 - cos(ang)) * c * b - sin(ang) * a
  
  return(rot_matrix)
}

# Function to project a 3D point onto a line (intersection of two planes)
# Inputs: P (point to project), plane equations defined by coefficients
project_point_to_line_3d <- function(P, alpha1 = 0, beta1 = 1, gamma1 = -1, delta1 = 0,
                                     alpha2 = 1, beta2 = 0, gamma2 = -1, delta2 = 0) {
  # Compute two points on the line
  x1 <- 0
  det_main <- det(rbind(c(beta1, gamma1), c(beta2, gamma2)))
  y1 <- det(rbind(c(-delta1, gamma1), c(-delta2, gamma2))) / det_main
  z1 <- det(rbind(c(beta1, -delta1), c(beta2, -delta2))) / det_main
  
  x2 <- 1
  y2 <- det(rbind(c(-delta1 - alpha1, gamma1), c(-delta2 - alpha2, gamma2))) / det_main
  z2 <- det(rbind(c(beta1, -delta1 - alpha1), c(beta2, -delta2 - alpha2))) / det_main
  
  # Compute the direction vector of the line
  dir_vector <- c(x2 - x1, y2 - y1, z2 - z1)
  
  # Equation of the perpendicular plane passing through point P
  a <- dir_vector[1]
  b <- dir_vector[2]
  c <- dir_vector[3]
  d <- -a * P[1] - b * P[2] - c * P[3]
  
  # Find the intersection of the line and the perpendicular plane
  D <- det(rbind(c(alpha1, beta1, gamma1), c(alpha2, beta2, gamma2), c(a, b, c)))
  Dx <- det(rbind(c(-delta1, beta1, gamma1), c(-delta2, beta2, gamma2), c(-d, b, c)))
  Dy <- det(rbind(c(alpha1, -delta1, gamma1), c(alpha2, -delta2, gamma2), c(a, -d, c)))
  Dz <- det(rbind(c(alpha1, beta1, -delta1), c(alpha2, beta2, -delta2), c(a, b, -d)))
  
  projected_point <- c(Dx / D, Dy / D, Dz / D)
  return(projected_point)
}



