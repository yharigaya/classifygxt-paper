# `sim`

This directory contains a Snakemake workflow for simulation.
For the initial submission, we set `filter.geno=TRUE` in `make_data.R` to exlude feature-SNP pairs without minor allele homozygotes.
In the revision, we set `filter.geno=FALSE` to include such feature-SNP pairs.
