#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --mem=24gb
#SBATCH --tmp=20gb
#SBATCH -t 02:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=liang797@umn.edu
#SBATCH -p ram256g,ram1t
#SBATCH -o %a.out
#SBATCH -e %a.err

set -e
set -o pipefail

# User provided input arguments
OUT_DIR=/panfs/roc/groups/9/morrellp/liang797/workspace/cowpea/
Primary_list=/panfs/roc/groups/9/morrellp/liang797/workspace/cowpea/files/Primary_NoPostfix.txt
GFF3_for_genes=/panfs/roc/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3

#-----------------
cd ${OUT_DIR}

# For CDS
python3 subset_GFF_CDS.py ${Primary_list} ${GFF3_for_genes} "/panfs/roc/groups/9/morrellp/liang797/workspace/cowpea/results/Primary_CDS.bed"