library(readr)
library(dplyr)
library(ggplot2)

# Handle file path whether executed from root or scripts/ directory
input_file <- "outputs/abricate_card_results.tsv"
if (!file.exists(input_file)) {
  input_file <- "../outputs/abricate_card_results.tsv"
}

if (!file.exists(input_file)) {
  stop("Input file abricate_card_results.tsv not found in outputs/ or ../outputs/")
}

data <- read_delim(input_file, delim = "\t", show_col_types = FALSE)

# Generate resistome profile plot
if ("GENE" %in% colnames(data) | "%COVERAGE" %in% colnames(data)) {
  p <- ggplot(data, aes(x = GENE, y = `%IDENTITY`, fill = `%COVERAGE`)) +
    geom_col() +
    coord_flip() +
    theme_minimal() +
    labs(title = "Bacterial Resistome Profile (CARD Database)",
         x = "Resistance Gene",
         y = "Sequence Identity (%)")
  
  output_plot <- "outputs/resistome_heatmap.png"
  if (!dir.exists("outputs")) dir.create("outputs")
  ggsave(output_plot, plot = p, width = 8, height = 6)
  cat("Resistome plot successfully saved to:", output_plot, "\n")
} else {
  cat("Data loaded successfully. Ready for downstream plotting.\n")
}
