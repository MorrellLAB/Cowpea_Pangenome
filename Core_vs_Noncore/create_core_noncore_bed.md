# Creating bed files of a core and noncore genes

## Data files, including VCF are below
[Google Drive](https://drive.google.com/drive/folders/1iQaLW4SLmN2lP7q4k3uovHK3SvsxGbVi)

* For gene names length, use the primary transcript, already reported in the files from Stefano Lonardi
* But, the GFF includes `.v1.2`in the 'ID' and the 'Parent' field but not in the 'Name' field
* Nathan's core gene list has names that look like the examples below with no transcript ID but a version number
Vigun01g000500.v1.2
Vigun01g000700.v1.2
* To match the "ID" in the "gene" line of the GFF, the gene has to have a name in the form above with no transcript number but ending in `.v1.2`

* On my local machine, the '-E' option in sed provides extended regex
```bash
sed -E 's/\.[0-9]+/.v1.2/g' /Users/pmorrell/Dropbox/Documents/Work/Manuscripts/Cowpea_Pangenome/dovetail/Manuscript/The\ Plant\ Genome/Core\ and\ Noncore/core_noncore_each_accession/IT97K_core.txt >~/Desktop/IT97K_core_gene.txt

sed -E 's/\.[0-9]+/.v1.2/g' /Users/pmorrell/Dropbox/Documents/Work/Manuscripts/Cowpea_Pangenome/dovetail/Manuscript/The\ Plant\ Genome/Core\ and\ Noncore/core_noncore_each_accession/IT97K_noncore.txt >~/Desktop/IT97K_noncore_gene.txt
```

```bash
module load python3/3.9.3_anaconda2021.11_mamba
pip install gffutils
```

* On UMN MSI working with the following files
/panfs/jay/groups/9/morrellp/pmorrell/Workshop/Cowpea/IT97K_core_gene.txt
/panfs/jay/groups/9/morrellp/pmorrell/Workshop/Cowpea/IT97K_noncore_gene.txt
/panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene.gff3.gz

```bash
python3 subset_GFF.py /panfs/jay/groups/9/morrellp/pmorrell/Workshop/Cowpea/IT97K_core_gene.txt /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene.gff3.gz /panfs/jay/groups/9/morrellp/pmorrell/Workshop/IT97K_core_gene.bed 

python3 subset_GFF.py  /panfs/jay/groups/9/morrellp/pmorrell/Workshop/Cowpea/IT97K_noncore_gene.txt /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene.gff3.gz /panfs/jay/groups/9/morrellp/pmorrell/Workshop/IT97K_noncore_gene.bed 

awk '{print $3 - $2}' /Users/pmorrell/Desktop/IT97K_core_gene.bed  | datamash -R 2 count 1 sum 1 mean 1 median 1 sstdev 1 min 1 max 1
[//]: 26026.00	109988075.00	4226.08	3292.00	4047.23	95.00	77528.00

awk '{print $3 - $2}' /Users/pmorrell/Desktop/IT97K_noncore_gene.bed | datamash -R 2 count 1 sum 1 mean 1 median 1 sstdev 1 min 1 max 1
[//]: 4963.00	11619995.00	2341.32	1347.00	3190.67	95.00	50226.00
```

* Create VCF files that include variants found in core and noncore genes
* SNPs & indels in core genes
```bash
module load bedtools/2.29.2
module load pigz/2.4  
cd /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan 
bedtools intersect -header -a /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_snps_filtered.g.vcf.gz \
-b /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/IT97K_core_gene.bed.gz | pigz >core_IT97K_combined_genotype_snps_filtered.g.vcf.gz

bedtools intersect -header -a /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_indels_filtered.g.vcf.gz \
-b /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/IT97K_core_gene.bed.gz | pigz >core_IT97K_combined_genotype_indels_filtered.g.vcf.gz

bedtools intersect -header -a /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_snps_filtered.g.vcf.gz \
-b /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/IT97K_noncore_gene.bed.gz | pigz > noncore_IT97K_combined_genotype_snps_filtered.g.vcf.gz &

bedtools intersect -header -a /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/SNPs/IT97K_combined_genotype_indels_filtered.g.vcf.gz \
-b /panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/IT97K_noncore_gene.bed.gz | pigz > noncore_IT97K_combined_genotype_indels_filtered.g.vcf.gz

[//]: Find the number of variants (SNPs and indels) in core and noncore genes 
zgrep -v '#' core_IT97K_combined_genotype_snps_filtered.g.vcf.gz | wc -l
>>>702073
zgrep -v '#' core_IT97K_combined_genotype_indels_filtered.g.vcf.gz | wc -l
>>>161900
zgrep -v '#' noncore_IT97K_combined_genotype_snps_filtered.g.vcf.gz | wc -l
>>>239100
zgrep -v '#' noncore_IT97K_combined_genotype_indels_filtered.g.vcf.gz | wc -l
>>>39845
```

* The VCF files to be used for VeP variant annotation - send to Elaine!
noncore_IT97K_combined_genotype_snps_filtered.g.vcf.gz
noncore_IT97K_combined_genotype_indels_filtered.g.vcf.gz
core_IT97K_combined_genotype_indels_filtered.g.vcf.gz
core_IT97K_combined_genotype_snps_filtered.g.vcf.gz


```R
core <- read.table("~/Dropbox/Documents/Work/Manuscripts/Cowpea_Pangenome/core_lengths.txt")
noncore <- read.table("~/Dropbox/Documents/Work/Manuscripts/Cowpea_Pangenome/noncore_lengths.txt")
wilcox.test(core[,1],noncore[,1])

[//]:	 Wilcoxon rank sum test with continuity correction

[//]: data:  core[, 1] and noncore[, 1]
[//]: W = 94459524, p-value < 2.2e-16
[//]: alternative hypothesis: true location shift is not equal to 0
```
