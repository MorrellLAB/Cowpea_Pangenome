#!/usr/bin/env python3
#    Chenxi Liang - Minneapolis, MN - 16 April 2022
#    Find the coordinates of specific lists of genes in a GFF3 file.
#    Write out a BED file that includes the coordinates of SNP intervals to include


import sys
import gffutils as gf


# creates the BED file that includes the CDS coordinates of SNP intervals
def get_bed_cds(genes, db, name):
    fn = open(name, "w+")
    for feature in db.features_of_type('CDS'):
        for gene in genes:
            length = len(gene)
            if gene[0:length] == str(feature.id)[0:length]:
                fn.write(feature.chrom + '\t' +  str(feature.start) + '\t' + str(feature.stop) + '\t'  + feature.featuretype + '\t' + str(feature.id) +'\n')
    fn.close()

# reads the genes from the core or noncore header list
def get_genes(path_genes):
    genes = open(path_genes, 'r').read().splitlines()
    return genes


# opens the file provided and reads the content into a database
def read_to_database(path_annotation):
    db = gf.create_db(path_annotation, ':memory:')
    return db


# path_genes: Path to the gene header list
# path_annotation: Path to the GFF reference file
# output_name: path and name of the output file
def main(path_genes, path_annotation, output_name):
    """Main function."""
    # Creates the database and prepare the list of genes for creating the bed file

    # Construct the database
    db = read_to_database(path_annotation)

    # Read the core / non-core genes from file
    genes = get_genes(path_genes)

    # Construct the output file
    get_bed_cds(genes, db, output_name)


# checks if the program has correct numbers of arguments
if len(sys.argv) <= 3:
    print("""Take two input files, a list of genes to extract and gzipped GFF3 file.
    1) Full path to list of genes to cut from GFF3
    2) Full path to the GFF3 
    3) Name of the output file""")
    exit(1)
else:
    main(sys.argv[1], sys.argv[2], sys.argv[3])

