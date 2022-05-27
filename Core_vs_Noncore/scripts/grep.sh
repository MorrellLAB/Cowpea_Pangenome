#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem=24gb
#SBATCH --tmp=20gb
#SBATCH -t 08:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=liang797@umn.edu
#SBATCH -p ram256g,ram1t
#SBATCH -o %a.out
#SBATCH -e %a.err

set -e
set -o pipefail

# User provided input arguments
search_items="/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/ITKcore.txt"
# Full filepath to output directory
out_dir="/panfs/roc/groups/9/morrellp/liang797/workspace/cowpea"
# Full filepath to reference fasta file
reference_gff="/panfs/roc/groups/9/morrellp/liang797/workspace/cowpea/genes_only_gff_Vunguiculata_IT97K-499-35_v1.txt"

#-----------------
# Grep for desired  items and gets the first third and fourth column 
grep -E -f ${search_items} ${reference_gff} | cut -f 1,4,5 > ${out_dir}/result.txt
