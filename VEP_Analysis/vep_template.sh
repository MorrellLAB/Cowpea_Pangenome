#!/bin/bash -l
#SBATCH --time=18:00:00
#SBATCH --ntasks=4
#SBATCH --mem=16g
#SBATCH --tmp=16g
#SBATCH --mail-type=ALL
#SBATCH --mail-user=YOUR_EMAIL

# This script runs Variant effect Predictor (VeP) on a set of variants
# It requires a VCF, GFF, and fasta file as input

#Dependencies
module load htslib/1.9
module load perl/modules.centos7.5.26.1

# Variant sets should be either 'all', deletions', 'insertions', 'snps', 'common', or 'rare'
VARIANT_SET=

# Add path to .vcf file 
VCF=
# Add path to .gff file 
GFF=
# Add path to reference fasta 
FASTA=

# Specify out directory
OUT=
cd "${OUT}"

/home/morrellp/shared/Software/ensembl-vep-release-97.3/vep \
    -i "${VCF}" \
    --gff "${GFF}" \
    --fasta "${FASTA}" \
    --species cowpea \
    --total_length \
    --check_svs \
    --verbose \
    --format vcf \
    --force \
    --warning_file "cowpea_${VARIANT_SET}.txt" \
    -o "cowpea_${VARIANT_SET}.txt"
