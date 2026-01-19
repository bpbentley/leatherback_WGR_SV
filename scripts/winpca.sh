#!/bin/bash
#SBATCH -J DerCor_MEX
#SBATCH -o ./logs/winpca/%x_%a_%A.log
#SBATCH -e ./logs/winpca/%x_%a_%A.err
#SBATCH -p cpu
#SBATCH -t 12:00:00
#SBATCH -c 4  # Number of Cores per Task
#SBATCH --mem=32G  # Requested Memory
#SBATCH --array=14

# === Load conda and the associated environment ===
module load conda/latest
conda activate turtles

# === Specify the chromosome for the array and extract length ===
CHR=SUPER_${SLURM_ARRAY_TASK_ID}
LEN=$(sed -n ${SLURM_ARRAY_TASK_ID}p ./ref/rDerCor1.pri.cur.20210524.fasta.scaffold.lengths.txt | cut -f2)

# === Pull the variants from the chromosome from the full VCF ===
#vcftools --gzvcf ./data/DerCor_analysis.vcf.gz --chr ${CHR} --recode --out ./data/chr/${CHR}/${CHR}

# === Just take the biallelic SNPs and index the VCF ===
#bcftools view --types snps -m 2 -M 2 ./data/chr/${CHR}/${CHR}.recode.vcf -Oz -o ./data/chr/${CHR}/${CHR}_biallelic.vcf.gz
#bcftools index ./data/chr/${CHR}/${CHR}_biallelic.vcf.gz

# === Run the winpca PCA script and plot PC1 and heterozygosity for all samples ===
#./winpca/winpca pca --np ./outputs/${CHR} ./data/chr/${CHR}/${CHR}_biallelic.vcf.gz ${CHR}:1-${LEN}
#./winpca/winpca chromplot -i 10 ./outputs/${CHR} ${CHR}:1-${LEN} -m ./final_meta.txt -g MU_DNA Eastern_Pacific:A7BDDE,Indo-Western_Pacific:B3D2AC,Northeast_Caribbean:B8ADD4,Northern_Caribbean:EFF4DA,Northwest_Caribbean:96AB95,SE_Atlantic/West_Africa:FCC89D,South-east_Caribbean:C9AFA6,South_Africa:B5E2E9,Western_Pacific:F6A388 -f HTML,SVG
#./winpca/winpca chromplot -i 10 -p het ./outputs/${CHR} ${CHR}:1-${LEN} -m ./final_meta.txt -g MU_DNA Eastern_Pacific:A7BDDE,Indo-Western_Pacific:B3D2AC,Northeast_Caribbean:B8ADD4,Northern_Caribbean:EFF4DA,Northwest_Caribbean:96AB95,SE_Atlantic/West_Africa:FCC89D,South-east_Caribbean:C9AFA6,South_Africa:B5E2E9,Western_Pacific:F6A388 -f HTML,SVG

# === Run it again on the MEX/STX mother/daughter/grandmother samples ===
mkdir -p ./data/chr_old/${CHR}/MEX_STX_pairs
mkdir -p ./outputs/MEX_STX_pairs

# Mexico
#bcftools view --force-samples -S MEX_samples.txt -Oz -o ./data/chr_old/${CHR}/MEX_STX_pairs/MEX_pairs_${CHR}.vcf.gz ./data/chr_old/${CHR}/${CHR}_biallelic.vcf.gz
#./winpca/winpca pca --np ./outputs/MEX_STX_pairs/MEX_pairs_${CHR} ./data/chr_old/${CHR}/MEX_STX_pairs/MEX_pairs_${CHR}.vcf.gz ${CHR}:1-${LEN}
./winpca/winpca chromplot -i 10 ./outputs/MEX_STX_pairs/MEX_pairs_${CHR} ${CHR}:1-${LEN} -m ./MEX_meta.txt -g MF -f HTML,SVG

# St. Croix
#bcftools view --force-samples -S STX_samples.txt -Oz -o ./data/chr_old/${CHR}/MEX_STX_pairs/STX_pairs_${CHR}.vcf.gz ./data/chr_old/${CHR}/${CHR}_biallelic.vcf.gz
#./winpca/winpca pca --np ./outputs/MEX_STX_pairs/STX_pairs_${CHR} ./data/chr_old/${CHR}/MEX_STX_pairs/STX_pairs_${CHR}.vcf.gz ${CHR}:1-${LEN}
#./winpca/winpca chromplot -i 10 ./outputs/MEX_STX_pairs/STX_pairs_${CHR} ${CHR}:1-${LEN} -m ./STX_meta.txt -g Kin -f HTML,SVG

#./winpca/winpca pca --np ./outputs/WPac_Caribbean/${CHR} ./data/chr/${CHR}/WPac_Caribbean/WPac_Caribbean_${CHR}.vcf.gz ${CHR}:1-${LEN}
#./winpca/winpca chromplot -i 10 ./outputs/WPac_Caribbean/${CHR} ${CHR}:1-${LEN} -m ./WPac_Caribbean_meta.txt -g MU_DNA
#./winpca/winpca chromplot -i 10 -p het ./outputs/WPac_Caribbean/${CHR} ${CHR}:1-${LEN} -m ./WPac_Caribbean_meta.txt -g MU_DNA

# === Deactivate conda environment ===
conda deactivate
echo "winpca analysis complete for" ${CHR}
