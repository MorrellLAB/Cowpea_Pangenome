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
OUT_DIR=/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/
Core_genes_list=/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/files/ITKcore.txt
Core_genes_list_no_postfix=/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/files/ITKcore_NoPostfix.txt
Noncore_genes_list=/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/files/ITKnoncore.txt
Noncore_genes_list_no_postfix=/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/files/ITKnoncore_NoPostfix.txt
GFF3_for_genes=/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3

#-----------------
cd ${OUT_DIR}

# For gene
python3 subset_GFF.py ${Core_genes_list} ${GFF3_for_genes} "/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/Core.bed"
python3 subset_GFF.py ${Noncore_genes_list} ${GFF3_for_genes} "/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/NonCore.bed"

# For CDS
python3 subset_GFF_CDS.py ${Core_genes_list_no_postfix} ${GFF3_for_genes} "/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/Core_CDS.bed"
python3 subset_GFF_CDS.py ${Noncore_genes_list_no_postfix} ${GFF3_for_genes} "/panfs/roc/groups/9/morrellp/liang797/workspace/cowepea/NonCore_CDS.bed"
