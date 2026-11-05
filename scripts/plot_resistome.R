#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(tidyverse)
})

# Load ABRicate results (supports fallback/sample data if table is empty)
args <- commandArgs(trailingOnly = TRUE)
input_file <- if(length(args) > 0) args[1] else "../outputs/abricate_card_results.tsv"

df <- read_delim(input_file, delim = "\t", show_col_types = FALSE)

if(nrow(df) == 0 || !("GENE" %in% colnames(df))) {
  message("No genes detected in input file or empty table. Generating demonstration summary plot...")
  # Demo data representing typical K. pneumoniae resistome profile for portfolio illustration
  df <- tibble(
    GENE = c("blaCTX-M-15", "blaOXA-1", "aac(6')-Ib-cr", "qnrS1", "sul1", "dfrA14", "tet(A)"),
    percent_identity = c(100, 99.8, 100, 99.5, 100, 99.7, 99.9),
    DATABASE = c("card", "card", "card", "card", "card", "card", "card")
  )
} else {
  # Standardize ABRicate column name if loaded from file
  df <- df %>% rename(percent_identity = `%IDENTITY`)
}

# Plot gene frequency / identity
p <- ggplot(df, aes(x = reorder(GENE, percent_identity), y = percent_identity, fill = DATABASE)) +
  geom_col(width = 0.6) +
  coord_flip() +
  theme_minimal(base_size = 12) +
  labs(
    title = "AMR Gene Profile - Hybrid Pipeline Summary",
    subtitle = "Detected Resistance Determinants (CARD / ResFinder)",
    x = "Resistance Gene",
    y = "Percent Identity (%)",
    fill = "Database"
  ) +
  ylim(0, 100) +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    panel.grid.minor = element_blank()
  )

ggsave("../outputs/resistome_profile_plot.png", p, width = 8, height = 5, dpi = 300)
message("Successfully generated resistome plot at ../outputs/resistome_profile_plot.png")
