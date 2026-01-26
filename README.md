# Structural Variation analysis for leatherback turtle whole-genome resequencing

## Source(s):
[winpca](https://github.com/MoritzBlumer/winpca)
Blumer, L. M., Good, J. M., & Durbin, R. (2025). WinPCA: A package for windowed principal component analysis. Bioinformatics (Oxford, England). https://doi.org/10.1093/bioinformatics/btaf529

## Summary:
These scripts use the 177 leatherback whole-genomes to test for structural variations between/within management units defined through previous DNA interrogation. The scripts leverage WinPCA (Blumer et al. 2025) to generate per-window PCAs (100 kbp) and visualize differences along the length of the genome. Additional analyses were applied to determine kinship between all individuals, and for known lineages within the St. Croix and Mexico samples. WinPCA was applied separately on these samples to assess inheritance patterns and examine potential genomic incompatabilities.

## Project structure: 
```
root
│   README.md
│
└───scripts
│		winpca.sh
│		kinship.sh
│   
└───metadata
│		final_meta.txt
│		STX_meta.txt
│		MEX_meta.txt
│
└───data
|	└───pca
│			SUPER_1.pc_1.tsv.gz
│			SUPER_1.pc_2.tsv.gz
│			SUPER_1.hetp.tsv.gz
│			...
│			SUPER_28.pc_1.tsv.gz
│			SUPER_28.pc_2.tsv.gz
│			SUPER_28.hetp.tsv.gz
|					
└───outputs
		└───winpca 
		|		SUPER_1.pc_1.html
		|		SUPER_1.hetp.html
		|		...
		|		SUPER_28.hetp.html
		|		SUPER_28.hetp.html
		|		SV_regions.txt
		|	
		└───kinship_out
			|	DerCor_kinship_all.kin0
			|	MEX_kinship.kin0
			|	STX_kinship.kin0	
```