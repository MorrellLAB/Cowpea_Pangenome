# **Scripts**



### **Subset_GFF.py**


* Find the coordinates of specific lists of genes in a GFF3 file.
* Write out a BED file that includes the coordinates of SNP intervals to include.

**Imports**

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
    * path_genes: Path to the gene header list
    * path_annotation: Path to the GFF reference file
    * output_name: path and name of the output file
  
    **Output**
    *  Creates the database and prepare the list of genes for creating the bed file

<br /> 


[//]: # (source code)
#### **get_bed**
          def get_bed(genes, db, name):
                fn = open(name, "w+")
                for i in genes:
                    locus = db[i]
                    fn.write(locus.chrom + '\t' +  str(locus.start) + '\t' + str(locus.stop) + '\t'  + locus.featuretype + '\t' + str(locus.id) + '\n')
                fn.close() 
#### **get_genes**

        def get_genes(path_genes):
            genes = open(path_genes, 'r').read().splitlines()
            return genes

#### **read_to_database**

        def read_to_database(path_annotation):
            db = gf.create_db(path_annotation, ':memory:')
            return db

#### **Main Method**

        def main(path_genes, path_annotation, output_name):

            # Construct the database
            db = read_to_database(path_annotation)

            # Read the core / non-core genes from file
            genes = get_genes(path_genes)

            # Construct the output file
            get_bed(genes, db, output_name)

        # checks if the program has correct numbers of arguments
        if len(sys.argv) <= 3:
            print("""Take two input files, a list of genes to extract and gzipped GFF3 file.
            1) Full path to list of genes to cut from GFF3
            2) Full path to the GFF3 
            3) Name of the output file""")
            exit(1)
        else:
            main(sys.argv[1], sys.argv[2], sys.argv[3])

<br></br>

### **Subset_GFF.sh**

<details>
<summary> <b> User Provided Input Arguments </b> </summary>

> OUT_DIR=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/`
> 
> Core_genes_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/`
> 
> Core_genes_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore.txt"`
> 
> Core_genes_list_no_postfix=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKcore_NoPostfix.txt"`
>
> Noncore_genes_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore.txt"`
>
> Noncore_genes_list_no_postfix=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/ITKnoncore_NoPostfix.txt"`
> 
> GFF3_for_genes=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3"`
> 
> GFF_SCRIPT=`"/panfs/jay/groups/9/morrellp/liang797/workspace/Cowpea_Pangenome/scripts/subset_GFF.py"`
> 
> GFF_CDS=`"/panfs/jay/groups/9/morrellp/liang797/workspace/Cowpea_Pangenome/scripts/subset_GFF_CDS.py"`

</details>




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
  
**Imports**

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
* path_genes: Path to the gene header list
* path_annotation: Path to the GFF reference file
* output_name: path and name of the output file
**Output**
* Creates the database and prepare the list of genes for creating the bed file
#### **get_bed_cds**
        def get_bed_cds(genes, db, name):
            fn = open(name, "w+")
            for feature in db.features_of_type('CDS'):
                for gene in genes:
                    length = len(gene)
                    if gene[0:length] == str(feature.id)[0:length]:
                        fn.write(feature.chrom + '\t' +  str(feature.start) + '\t' + str(feature.stop) + '\t'  + feature.featuretype + '\t' + str(feature.id) +'\n')
            fn.close()


#### **get_genes**

    def get_genes(path_genes):
        genes = open(path_genes, 'r').read().splitlines()
        return genes

#### **read_to_database**

    def read_to_database(path_annotation):
        db = gf.create_db(path_annotation, ':memory:')
        return db

#### **Main Method CDS**

    def main(path_genes, path_annotation, output_name):
        """Main function."""

    Construct the database

        db = read_to_database(path_annotation)

    Read the core / non-core genes from file

        genes = get_genes(path_genes)

    Construct the output file

        get_bed_cds(genes, db, output_name)

    Checks if the program has correct numbers of arguments

        if len(sys.argv) <= 3:
            print("""Take two input files, a list of genes to extract and gzipped GFF3 file.
            1) Full path to list of genes to cut from GFF3
            2) Full path to the GFF3 
            3) Name of the output file""")
            exit(1)
        else:
            main(sys.argv[1], sys.argv[2], sys.argv[3])

<br></br>

### **Primary_cds.sh**

<details>
<summary> <b> User Provided Input Arguments </b> </summary>

> SCRIPT_DIR=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/scripts"`
> 
> Primary_list=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Primary_chro.txt"`
> 
> GFF3_for_genes=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/files/Vunguiculata_IT97K-499-35_v1.2.gene.gff3"`
> 
> OUT_DIR=`"/panfs/jay/groups/9/morrellp/liang797/workspace/cowpea/results"`
> 
> NAME=`"Correct_Primary_CDS.bed"`

</details>

To run subset_GFF for find the coordinate for CDS of SNP intervals for primary transcript

    python3 subset_GFF_CDS.py ${Primary_list} ${GFF3_for_genes} ${OUT_DIR}/${NAME}
