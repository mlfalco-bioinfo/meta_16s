# Load necessary libraries
library(phyloseq)
library(ggplot2)
library(dplyr)
library(vegan)

# Define the directory containing the input files
input_dir <- "path/to/your/input/files"

# Function to process each file
process_file <- function(file_path) {
  # Load the data (example for QIIME2 output)
  ps <- readRDS(file_path)
  
  # Calculate relative abundance
  ps_rel_abundance <- transform_sample_counts(ps, function(x) x / sum(x))
  
  # Perform diversity analysis
  alpha_div <- estimate_richness(ps)
  beta_div <- ordinate(ps, method = "PCoA", distance = "bray")
  
  # Statistical analysis (example: PERMANOVA)
  perm_test <- adonis(distance(ps) ~ sample_data(ps)$Group, data = sample_data(ps))
  
  # Visualization
  p1 <- plot_richness(ps, x = "Group", measures = c("Shannon", "Simpson"))
  p2 <- plot_ordination(ps, beta_div, color = "Group") + geom_point(size = 3)
  
  # Save plots
  ggsave(filename = paste0("alpha_diversity_", basename(file_path), ".png"), plot = p1)
  ggsave(filename = paste0("beta_diversity_", basename(file_path), ".png"), plot = p2)
  
  return(list(alpha_div = alpha_div, beta_div = beta_div, perm_test = perm_test))
}

# Process all files in the directory
results <- lapply(list.files(input_dir, full.names = TRUE), process_file)

# Save results
saveRDS(results, file = "analysis_results.rds")
