# Structural Variation analysis for leatherback turtle whole-genome resequencing

## Source(s):
[winpca](https://github.com/MoritzBlumer/winpca)
Blumer, L. M., Good, J. M., & Durbin, R. (2025). WinPCA: A package for windowed principal component analysis. Bioinformatics (Oxford, England). https://doi.org/10.1093/bioinformatics/btaf529

## Summary:
These scripts use the 177 leatherback whole-genomes to test for structural variations between/within management units defined through previous DNA interrogation. The scripts leverage WinPCA (Blumer et al. 2025) to generate per-window PCAs (100 kbp) and visualize differences along the length of the genome. Additional analyses were applied to determine kinship between all individuals, and for known lineages within the St. Croix and Mexico samples. WinPCA was applied separately on these samples to assess inheritance patterns and examine potential genomic incompatabilities.

## Directory structure: 
|
|--- Scripts
|--- Metadata
|--- Data
|--- Outputs