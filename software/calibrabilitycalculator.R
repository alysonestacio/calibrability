
# Functions to calculate regional and catchment calibrability

# Function to compute the regional calibrability matrix
# Inputs: performance matrix, errorMesure (optional, default = FALSE)
compute_regional_calibrability <- function(performance_data, errorMesure = FALSE) {
  models <- colnames(performance_data)
  calibrability_matrix <- matrix(nrow = length(models), ncol = length(models))
  
  # Compute pairwise calibrability
  for (m1 in 1:length(models)) {
    for (m2 in 1:length(models)) {
      coef <- orthogonal_regression(performance_data[, m1], performance_data[, m2])$par
      calibrability_matrix[m1, m2] <- round(atan(coef) / pi * 180 - 45, 2)
    }
  }
  
  # Adjust for error measure if specified
  if (errorMesure) {
    calibrability_matrix <- calibrability_matrix * -1
  }
  
  rownames(calibrability_matrix) <- paste0("y-", models)
  colnames(calibrability_matrix) <- paste0("x-", models)
  
  return(calibrability_matrix)
}

# Function to compute the catchment calibrability vector
compute_catchment_calibrability <- function(performance_data, errorMesure = FALSE) {
  num_models <- ncol(performance_data)
  
  # Calculate orthogonal regression coefficients
  coefficients <- numeric(num_models)
  coefficients[1] <- 1
  for (m in 2:num_models) {
    coefficients[m] <- orthogonal_regression(performance_data[, m], performance_data[, 1])$par
  }
  
  # Normalize vectors
  orth_reg_vector <- coefficients / sqrt(sum(coefficients^2))
  bisector_vector <- rep(1, num_models) / sqrt(num_models)
  
  # Calculate rotation angle
  rotation_angle <- acos(sum(orth_reg_vector * bisector_vector))
  
  # Compute normal vector and rotation matrix
  normal_vector <- cross_product_3d(orth_reg_vector, bisector_vector)
  normal_vector <- normal_vector / sqrt(sum(normal_vector^2))
  rotation_matrix <- rotation_matrix_3d(normal_vector, rotation_angle)
  
  # Rotate performance data and compute mean
  rotated_performances <- t(rotation_matrix %*% t(performance_data))
  catchment_calibrability <- apply(rotated_performances, 1, mean)
  
  return(catchment_calibrability)
}
