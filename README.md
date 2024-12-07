
# Calibrability Calculator

This repository contains a set of R scripts for calculating calibrability metrics for performance data across multiple models. It includes tools for computing **regional calibrability matrices** and **catchment calibrability vectors** based on orthogonal regression and geometric transformations.

## Repository Structure

```
.
├── aux_geom.R             # Auxiliary geometric functions
├── calibrabilitycalculator.R # Functions to compute calibrability metrics
├── example.R              # Example script demonstrating usage
├── example_data/          # Folder containing example performance data
└── README.md              # Documentation for the repository
```

### Scripts

1. **`aux_geom.R`**  
   Contains general-purpose geometric and mathematical functions, including:
   - Distance computation between points and lines.
   - Orthogonal regression fitting.
   - Cross-product and 3D rotation matrix computation.
   - Point projection onto a 3D line.

2. **`calibrabilitycalculator.R`**  
   Implements functions to compute:
   - **Regional calibrability matrix**: Pairwise calibrability between models.
   - **Catchment calibrability vector**: Aggregated calibrability across all models.

3. **`example.R`**  
   Provides a practical demonstration of how to use the functions defined in the other scripts:
   - Loads example data from the `example_data/` directory.
   - Computes both regional and catchment calibrability metrics for each dataset.

4. **`example_data/`**  
   A folder containing example `.csv` files representing performance metrics.  
   File names follow the pattern `performances__<metric_name>.csv`, where `<metric_name>` is the specific metric.

---

## Prerequisites

Ensure the following R packages are installed:

- **base** (default R installation)
- **stats** (for `optim()` function)

## Usage

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd calibrability-calculator
   ```

2. Prepare your performance data in `.csv` format. Each file should:
   - Contain performance data as rows, with models as columns.
   - Have no header for row indices.

3. Update the file paths in `example.R`:
   ```R
   arq_performances <- list.files("<your_example_data_path>", full.names = TRUE)
   ```

4. Run the example script:
   ```R
   source("example.R")
   ```

---

## Outputs

### Regional Calibrability
The **regional calibrability matrix** quantifies the pairwise calibrability of all models in terms of rotation angles.  
Output: A square matrix with:
- Rows: `y-<model_name>`
- Columns: `x-<model_name>`

### Catchment Calibrability
The **catchment calibrability vector** aggregates model calibrability in higher-dimensional space.  
Output: A single vector with an average calibrability value for each model.

---

## Example Dataset

The `example_data/` folder includes synthetic `.csv` files for testing. Update the file paths in `example.R` to run the calculations on this data.

---



