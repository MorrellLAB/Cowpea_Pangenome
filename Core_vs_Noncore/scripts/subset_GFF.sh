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
OUT_DIR=/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/
Core_genes_list=/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore.txt
Core_genes_list_no_postfix=/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore_NoPostfix.txt
Noncore_genes_list=/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore.txt
Noncore_genes_list_no_postfix=/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore_NoPostfix.txt
GFF3_for_genes=/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3

#-----------------
cd ${OUT_DIR}

# For gene
python3 subset_GFF.py ${Core_genes_list} ${GFF3_for_genes} "/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/Core.bed"
python3 subset_GFF.py ${Noncore_genes_list} ${GFF3_for_genes} "/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/NonCore.bed"

# For CDS
python3 subset_GFF_CDS.py ${Core_genes_list_no_postfix} ${GFF3_for_genes} "/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/Core_CDS.bed"
python3 subset_GFF_CDS.py ${Noncore_genes_list_no_postfix} ${GFF3_for_genes} "/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/NonCore_CDS.bed"
