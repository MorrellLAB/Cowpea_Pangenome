# **Core vs NonCore**



### **Subset_GFF.py**


* Find the coordinates of specific lists of genes in a GFF3 file.
* Write out a BED file that includes the coordinates of SNP intervals to include.

**Dependencies**

* `import sys`
* `import gffutils as gf`

**Methods**

* [`def get_bed(genes, db, name)`](#getbed)
    >creates the BED file that includes the coordinates of SNP intervals
* [`def get_genes(path_genes)`](#getgenes)
    > reads the genes from the core or non-core header list
* [`def read_to_database(path_annotation)`](#readtodatabase)
    > opens the file provided and reads the content into a database
* **[`def main(path_genes, path_annotation, output_name)`](#main-method)**
    
    **Parameters**
    * **path_genes**: Path to the gene header list
    * **path_annotation**: Path to the GFF reference file
    * **output_name**: path and name of the output file
  
    **Output**
    *  A BED file contains selected gene from the reference GFF


<br></br>

### **Subset_GFF.sh**

**Inputs**

- OUT_DIR=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/`

- Core_genes_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/`

- Core_genes_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore.txt"`

- Core_genes_list_no_postfix=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore_NoPostfix.txt"`

- Noncore_genes_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore.txt"`

- Noncore_genes_list_no_postfix=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore_NoPostfix.txt"`
 
- GFF3_for_genes=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3"`
 
- GFF_SCRIPT=`"/panfs/jay/groups/9/morrellp/liang797/workspace/Cowpea_Pangenome/scripts/subset_GFF.py"`
 
- GFF_CDS=`"/panfs/jay/groups/9/morrellp/liang797/workspace/Cowpea_Pangenome/scripts/subset_GFF_CDS.py"`


To run subset_GFF for find the coordinate for gene of SNP intervals:

     python3 ${GFF_SCRIPT} ${Core_genes_list} ${GFF3_for_genes} $ {OUT_DIR}/"Core.bed"
     ${GFF_SCRIPT} ${Noncore_genes_list} ${GFF3_for_genes} ${OUT_DIR}/"NonCore.bed"

To run subset_GFF for find the coordinate for CDS of SNP intervals
    
    python3 ${GFF_CDS} ${Core_genes_list_no_postfix} ${GFF3_for_genes} ${OUT_DIR}/"Core_CDS.bed"
    python3 ${GFF_CDS} ${Noncore_genes_list_no_postfix} ${GFF3_for_genes} ${OUT_DIR}/"NonCore_CDS.bed"

<br></br>

### **Subset_GFF_CDS.py**

* Find the coordinates of specific lists of genes in a GFF3 file.
* *Write out a BED file that includes the coordinates of SNP intervals to include
  
**Dependencies**

* `import sys`
* `import gffutils as gf`

**Methods**

* [`def get_bed_cds(genes, db, name):`](#getbedcds)
> Creates the BED file that includes the CDS coordinates of SNP intervals
* [`def get_genes(path_genes):`](#getgenes)
> Reads the genes from the core or noncore header list
* [`def read_to_database(path_annotation):`](#readtodatabase)
> opens the file provided and reads the content into a database
* **[`def main(path_genes, path_annotation, output_name):`](#main-method-cds)**

**Parameters**
* **path_genes**: Path to the gene header list
* **path_annotation**: Path to the GFF reference file
* **output_name**: path and name of the output file

**Output**
* A BED file contains selected CDS from the reference GFF

<br></br>
### **Primary_cds.sh**
**inputs**
- SCRIPT_DIR=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/scripts"`
 
- Primary_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Primary_chro.txt"`
 
- GFF3_for_genes=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3"`
 
- OUT_DIR=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/results"`
 
- NAME=`"Correct_Primary_CDS.bed"`

To run subset_GFF for find the coordinate for CDS of SNP intervals for primary transcript

    python3 subset_GFF_CDS.py ${Primary_list} ${GFF3_for_genes} ${OUT_DIR}/${NAME}

<br></br>

