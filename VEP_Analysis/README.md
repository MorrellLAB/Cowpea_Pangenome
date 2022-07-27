# Variant Effect Predictor 

Variant Effect Predictor (VEP) analysis was performed to determine the effects of SNPs and indels in both core and noncore genes
    
   
# Dependecies
- HTSlib 1.9
- CentOS 7.5.26.1
- Ensembl VEP 97.3
   
     
# Method     
Core and non-core genes were extracted from the IT97K assembly and VEP analysis was performed on each of the following groups:     
- Core SNPs   
- Noncore SNPs  
- Core indels   
- Noncore indels   

The following are a template and an example script used to run VEP:   
- Template script: `vep_template.sh` 
- Example script: 
       
       
# Files 
- Core SNPs: 
- Noncore SNPs: 
- Core indels:   
- Noncore indels:
- GFF assembly: `/panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/annotation/Vunguiculata_IT97K-499-35_v1.2.gene_exons.sort.gff3.gz`
- Reference genome: `/panfs/jay/groups/9/morrellp/shared/Datasets/Cowpea_Pan/VunguiculataIT97K-499-35_v1.2/assembly/Vunguiculata_IT97K-499-35_v1.0.fa.gz`
     
     
# Results   

The .html summaries are in: `add link`     
   
Data on SNPs and indels for core and noncore exons was extracted from the summaries and were plotted on a stacked bar chart to analyse the number of mutations at differing levels of severity. The code used to generate this plot is `vep_plot.py`

