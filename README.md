# AMR resistome workflow (learning project, in development)

A Linux/WSL2 (Conda) workflow I am building to learn short-read QC, hybrid
short- and long-read assembly and resistome annotation of bacterial isolates.

## Status
In development. The hybrid assembly stage is being validated on one public
*Klebsiella pneumoniae* isolate. Results will be added here when the run is
checked.

## Test dataset
*K. pneumoniae* isolate SAMD00186859 (public, DDBJ/ENA):
- Illumina paired-end: DRR192206 (2 x 251 bp)
- Oxford Nanopore: DRR193899 (mean read length about 6.8 kb)

Note: my first tests used ERR3772937 and ERR3772938. These are human Illumina
reads, so ABRicate correctly found no resistance genes. I replaced them with
the bacterial isolate above.

## Workflow
1. Short-read QC and trimming: fastp
2. Long-read filtering: Filtlong (best 500 Mb)
3. Hybrid assembly: Unicycler
4. Resistance, plasmid and gene annotation: ABRicate (CARD, ResFinder, PlasmidFinder)
5. Plot: R (tidyverse, ggplot2), see scripts/plot_resistome.R

## Environment
Conda environment `hybrid_env` (fastp 1.4.0, ABRicate 1.4.0, Filtlong 0.2.1,
Unicycler, seqkit). Raw reads and assemblies are not stored in this repository.

## Next steps
- Check assembly quality (contigs, circularity) and add a summary table
- Add an environment.yml and a single run script
- Add a worked example figure from the *K. pneumoniae* resistome
