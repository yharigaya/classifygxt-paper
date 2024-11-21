# `wntrna`

This directory contains a Snakemake workflow for analyzing response eQTL data in human neural progenitor cells (hNPCs) treated with CHIR, an activator of the Wnt pathway.
See the following publication for information about the input files.
Note that files containing individual genotype data can be accessed only upon request and approval.

Nana Matoba\*,
Brandon D Le\*,
Jordan M Valone\*,
Justin M Wolter,
Jessica T Mory,
Dan Liang,
Nil Aygun,
K Alaine Broadaway,
Marielle L Bond,
Karen L Mohlke,
Mark J Zylka,
Michael I Love,
Jason L Stein.
"Stimulating Wnt signaling reveals context-dependent genetic effects on gene regulation in primary human neural progenitors."
*Nat Neurosci.* 2024 Sep 30. 
doi: <https://doi.org/10.1038/s41593-024-01773-6>. 
PMID: 39349663 
(\* These authors contributed equally to this work.)

## Setup

The code requires the following input files in a directory(or a symbolic link to a directory) named `source_data` under the project directory.

- `WntRNA/media-11.xlsx`
- `WntRNA/media-14.xlsx`
- `WntRNA/limix_qtl/input/interaction/pheno.interaction.residuals.veh.CT99.PC10.MDS0.tsv`
- `WntRNA/limix_qtl/input/interaction/samplemap.interaction.veh.CT99.tsv`
- `WntRNA/limix_qtl/input/Wnt_all.kinship.tsv`
- `WntRNA/limix_qtl/input/Wnt_all.<chromosome>.wo.lowCT.bed`
- `WntRNA/resources/Homo_sapiens.GRCh38.104.collapse_gene_ID.gene_name.txt`
- `WntRNA/resources/Homo_sapiens.GRCh38.104.collapse.gtf`
- `WntIIRNAseq/baseQTL_IntermediateFiles/STAR_mapped/<sample_id>/<sample_id>.sorted.bam`

## Credits

Portions of the `get_fc.R` script have been adapted from <https://bitbucket.org/steinlabunc/wnt-rqtls/>.

