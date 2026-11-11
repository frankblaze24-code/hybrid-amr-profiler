FROM rocker/tidyverse:4.3.0

# Install system dependencies for bioinformatics and plotting
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    git \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install required R packages for resistome plotting
R -e "install.packages(c('readr', 'dplyr', 'ggplot2'), repos='https://cloud.r-project.org/')"

# Set working directory
WORKDIR /workspace

# Copy repository contents into container
COPY . /workspace/

# Default command to run visualization test
CMD ["Rscript", "scripts/plot_resistome.R"]
