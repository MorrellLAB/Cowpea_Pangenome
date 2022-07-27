## **File information**

#### **ITKCore.txt**
* This textfile contains all of the gene ids for the core gene in the ITK sample with postfix.

#### **ITKcore_NoPostfix.txt**

* This textfile contains all of the gene ids for the core gene in the ITK sample without postfix.

* Sets up for the [`subset_GFF.sh`](https://github.com/MorrellLAB/Cowpea_Pangenome/blob/main/subset_GFF.py) script

#### **ITKnoncore.txt**
*  This textfile contains all the gene ids for noncore genes that are present in the ITK sample. 

#### **ITKnoncore_NoPostfix.txt**
* This textfile contains all the gene ids for the noncore gene in the ITK sample without postFix

* Sets up for the [`subset_GFF.sh`](https://github.com/MorrellLAB/Cowpea_Pangenome/blob/main/subset_GFF.py) script

#### **Primary_chro.txt**
* This file contains all the pimary gene ids that are present in the ITK Sample 
* PostFix for `.#.`

## **Reference Files**

#### **Vunguiculata_IT97K-499-35_v1.2.cds_primaryTranscriptOnly.fa.gz**
*   Fasta reference of primary transcript with cds only
*   Used to produce Primary CDS Core vs NonCore analysis
#### **Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3.gz**
*   GFF3 reference for gene exons
#### **Vunguiculata_IT97K-499-35_v1.2.gene.gff3.gz**
*   GFF3 reference for gene 
*   Used to produce both gene and CDS Core vs NonCore analysis
