

# Example script for calculating calibrability metrics

# Load performance data files
performance_files <- list.files(".../example_data", full.names = TRUE)
metric_names <- gsub("performances__", "", basename(performance_files))
metric_names <- gsub(".csv", "", metric_names)

# Read and name performance data
performance_data_list <- lapply(performance_files, read.csv, row.names = 1)
names(performance_data_list) <- metric_names

# Load required scripts
source(".../aux_geom.R")
source(".../calibrabilitycalculator.R")

# Compute regional calibrability for all datasets
regional_calibrability_results <- lapply(performance_data_list, compute_regional_calibrability)

# Compute catchment calibrability for all datasets
catchment_calibrability_results <- lapply(performance_data_list, compute_catchment_calibrability)



