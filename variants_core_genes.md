20 February 2022
Peter L. Morrell
Falcon Heights, MN

# Partitioning of SNPs into those found in core and noncore genes

## Files needed include the following

* Core genes list - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/ITKcore.txt`
* Noncore genes list - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/ITKnoncore.txt`
* Core genes BED file - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/core_sort.bed`
* Noncore genes BED file  - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/noncore_sort.bed`
* GFF3 for genes - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene.gff3.gz`
* GFF3 for VeP analysis - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene_exons.sort.gff3.gz`
* VCF - SNPs `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_snps_filtered.g.vcf.gz `
* VCF - indels `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_indels_filtered.g.vcf.gz`
* FASTA - reference genome - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/assembly/Vunguiculata_IT97K-499-35_v1.0.fa.gz`
* VeP example script - `/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/ensembl_vep_Cowpea_noncore.sh`

## Tools for cutting up GFF3 files are limited, but  package below is useful

[gffutils](https://pythonhosted.org/gffutils/contents.html)

### gffutils is an easy install

```bash
pip3 install gffutils
```

### Testing gffutils on the command line

*    Starting with a raw (unsorted) GFF3 from JGI, decompressed
*    Going to read our list of core and noncore genes from a cut-down spreadsheet
*    Each gene needs to be listed on a single line in the form 'Vigun11g226200.v1.2'
*    We'll make these files available in the DRUM archive for the manuscript

###  Code block will read in a GFF3 and a list of genes

*    Output will be a BED file of positions where each gene occurs
*    This file can be used to cut down a VCF file to include SNPs in core or noncore genes
```python3
import gffutils
fn = gffutils.example_filename('/Users/pmorrell/Downloads/Vunguiculata_IT97K-499-35_v1.2.gene.gff3')
[// don't print] print(open(fn).read())
gene = db['Vigun11g226200.v1.2']
[// needed to add the '.v1.2' to the each of the gene names to make the code below work!]
genes = open('/Users/pmorrell/Downloads/ITKnoncore.txt','r').read().splitlines()
[//] genes = open('/Users/pmorrell/Downloads/ITKcore.txt','r').read().splitlines()
for i in genes:
    locus = db[i]
    print(locus.chrom,locus.start, locus.end, locus.id, sep='\t')
```

### The BED file created is not sorted. Can accomplish that with the code below.

```bash
/panfs/roc/groups/9/morrellp/pmorrell/Workshop/Cowpea
sort -k 1,1 -k2,2n noncore.txt >noncore_sort.bed
sort -k 1,1 -k2,2n IT97K_only_noncore.bed >IT97K_only_noncore_sort.bed
module load bcftools/1.9
```

### Can identify the overlap in a VCF and BED file (and cut down the VCF file) using either bedtools or bcftools

*   bedtools would look like this, but I'm not clear on how the information in the header is handled (seems like the header is just appended)
```bash
bedtools intersect -header -a IT97K_combined_genotype_snps_filtered.g.vcf.gz -b ~/Workshop/Cowpea/noncore_sort.bed >~/Workshop/Cowpea/noncore_IT97K_combined_geno
type_snps_filtered.g.vcf.gz
```

### Running bcftools requires more setup, but `bcftools view` will do the work

*   Need to perform a series of actions to setup cowpea
*   The genome, VCF, and GFF need to compress with `bgzip`
*   Need to unzip, bgzip, and typically reindex each file
*   GFF3 needs a tabix index, VCF will need a bcftools index version of indexing
*   Used rough Python code to create `noncore_sort.bed`
```bash
cd ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/
[//  copy the VCF to scratch and bgzip]
cp -aR IT97K_combined_genotype_snps_filtered.g.vcf.gz /scratch.global/pmorrell/Cowpea_pan/
gunzip /scratch.global/pmorrell/Cowpea_pan/IT97K_combined_genotype_snps_filtered.g.vcf.gz
[//  need htslib to get bgzip and tabix]
module load htslib
bgzip -@ 3 /scratch.global/pmorrell/Cowpea_pan/IT97K_combined_genotype_snps_filtered.g.vcf

cd ~/shared/Datasets/Cowpea_Pan/assembly/
cp -aR Vunguiculata_IT97K-499-35_v1.0.fa.gz /scratch.global/pmorrell/Cowpea_pan/
cd /scratch.global/pmorrell/Cowpea_pan/

[// copy the GFF to scratch, unzip and then index]
cp -aR /panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3.gz /scratch.global/pmorrell/Cowpea_pan/
cd /scratch.global/pmorrell/Cowpea_pan/
gunzip Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3.gz
[// sorting the GFF before we compress]
grep -v "#" Vunguiculata_IT97K-499-35_v1.2.gene_exons.gff3 | sort -k1,1 -k4,4n -k5,5n -t$'\t' | bgzip -c >Vunguiculata_IT97K-499-35_v1.2.gene_exons.sort.gff3.gz
tabix -p gff Vunguiculata_IT97K-499-35_v1.2.gene_exons.sort.gff3.gz

[// need to
cd ~/Workshop/Cowpea
gunzip noncore_IT97K_combined_genotype_snps_filtered.g.vcf.gz

module load bcftools/1.9

[// bgzip genome]
gunzip Vunguiculata_IT97K-499-35_v1.0.fa.gz
bgzip Vunguiculata_IT97K-499-35_v1.0.fa
```
### Copying files back to the original directories after bgzip and indexing

```bash
cd /scratch.global/pmorrell/Cowpea_pan
cp -aR IT97K_combined_genotype_snps_filtered.g.vcf.gz ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/
cp -aR IT97K_combined_genotype_snps_filtered.g.vcf.gz.csi ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/
cp -aR Vunguiculata_IT97K-499-35_v1.2.gene_exons.sort.gff3.gz ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/
cp -aR Vunguiculata_IT97K-499-35_v1.2.gene_exons.sort.gff3.gz.tbi ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/
cp -aR Vunguiculata_IT97K-499-35_v1.0.fa.gz ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/assembly/
cp -aR Vunguiculata_IT97K-499-35_v1.0.fa.gz.fai ~/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/assembly/
```

## Cutting down VCF file to contain only core or noncore gene-related variants

```bash
module load bcftools/1.10.2
bcftools view \
/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_snps_filtered.g.vcf.gz \
--regions-file \
/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/core_sort.bed \
--output-type z \
--output-file core_IT97K_combined_genotype_snps_filtered.g.vcf.gz
```


```bash
module load bcftools/1.10.2
bcftools view \
/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_snps_filtered.g.vcf.gz \
--regions-file \
/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/IT97K_only_noncore_sort.bed \
--output-type z \
--output-file /panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/noncore_only_IT97K_combined_genotype_snps_filtered.g.vcf.gz
```



## Using the summary of output of VeP from Elaine's runs to plot variants by class

```python3

import pandas as pd
df = pd.DataFrame({'Variant Set': ['Core - SNPs', 'Noncore - SNPs', 'Core - Indels', 'Noncore - Indels'], 'Synonymous': [89298, 100112, 0, 0], 'Inframe Indel': [0, 0, 3960, 6447], 'Missense': [81135, 170812, 0, 0], 'Stop Gain': [889, 3662, 196, 687], 'Start or Stop Change': [356, 836, 252, 297], 'Frameshift': [0, 0, 3672, 16908]})

import matplotlib.pyplot as plt
import seaborn as sns
sns.set(style='white')
sns.set(rc = {'figure.figsize':(15,8)})


df.set_index('Variant Set').plot(kind='bar', stacked=True, color=['steelblue', 'dodgerblue', 'salmon', 'darkred', 'red', 'firebrick'])
```

* 5 March 2022, continuing analysis on additional set of genes

## There are more stop gains and missense variants in noncore genes. This could \
## result from reduced purifying selection, but it could also be due to poorer \
## annotation or the inclusion of pseudogenes in the noncore annotations.
## To reduce the difference in quality of annotation, Tim and Maria suggested \
## looking at variants that are core and noncore in IT97K.
## Created a file with "noncore" genes that are present in IT97K. Using the spreadsheet \
## "gene_correspondance_noncore.xlsx".

```bash
[//  remove all the blank lines in list pasted from the spreadsheet]
[//  also needed to add `.v1.2` to the end of gene names]
sed '/^[[:space:]]*$/d' IT97K_noncore.txt >IT97K_only_noncore.txt


##  5 March 2022, running on IT97K only noncore genes
```bash
module load bcftools/1.10.2
[// creating the VCF for IT97K only noncore; need file for SNPs and indels]
bcftools view \
/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_indels_filtered.g.vcf.gz \
--regions-file \
/panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/IT97K_only_noncore_sort.bed \
--output-type z \
--output-file /panfs/roc/groups/9/morrellp/shared/Datasets/Cowpea_Pan/noncore_only_IT97K_combined_genotype_snps_filtered.g.vcf.gz
```
