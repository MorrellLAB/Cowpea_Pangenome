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
OUT_DIR="/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/"
Core_genes_list="/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore.txt"
Core_genes_list_no_postfix="/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore_NoPostfix.txt"
Noncore_genes_list="/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore.txt"
Noncore_genes_list_no_postfix="/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore_NoPostfix.txt"
GFF3_for_genes="/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3"
GFF_SCRIPT="/panfs/jay/groups/9/morrellp/liang797/workspace/Cowpea_Pangenome/scripts/subset_GFF.py"
GFF_CDS="/panfs/jay/groups/9/morrellp/liang797/workspace/Cowpea_Pangenome/scripts/subset_GFF_CDS.py"
#-----------------
cd ${OUT_DIR}

# To run subset_GFF for find the coordinate for gene of SNP intervals
python3 ${GFF_SCRIPT} ${Core_genes_list} ${GFF3_for_genes} ${OUT_DIR}/"Core.bed"
python3 ${GFF_SCRIPT} ${Noncore_genes_list} ${GFF3_for_genes} ${OUT_DIR}/"NonCore.bed"

# To run subset_GFF for find the coordinate for CDS of SNP intervals
python3 ${GFF_CDS} ${Core_genes_list_no_postfix} ${GFF3_for_genes} ${OUT_DIR}/"Core_CDS.bed"
python3 ${GFF_CDS} ${Noncore_genes_list_no_postfix} ${GFF3_for_genes} ${OUT_DIR}/"NonCore_CDS.bed"
