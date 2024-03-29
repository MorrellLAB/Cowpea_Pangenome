# Results 


| **[Core results](#core-results)** | **[NonCore Results](#noncore-results)** | **[Primary Results](#primary-results)** | **[Primary Core Results](#primary-core-results)**  | **[Primary NonCore Results](#primary-noncore-results)** |
|-----------------------------------|-----------------------------------------|-----------------------------------------|----------------------------------------------------|---------------------------------------------------------|
| **Core.bed**                      | **NonCore.bed**                         | **Primary_CDS.bed**                     | **Primary_Core_CDS.bed**                           | **Primary_NonCore_CDS_Distance.txt**                    |
| **Core_CDS.bed**                  | **NonCore_CDS.bed**                     | **Primary_CDS.Distance.txt**            | **Primary_Core_CDS_Distance.txt**                  | **Primary_Noncore_CDS.bed**                             |
| **Core_CDS_Distance.txt**         | **NonCore_CDS_Distance.txt**            |                                         |                                                    |                                                         |
| **Core_Distance.txt**             | **NonCore_Distance.txt**                |                                         |                                                    |                                                         |

<br></br>



## **Methods**
To get rid of the postfix of `.v1.2` for easier pattern match from the core and noncore file, I used:
    
    % cat ITKcore.txt | sed 's/.v1.2//g' > ITKcore_NoPostfix.txt

To generate the Primar_chro.txt, I used follwing command the extract and get rid of the postfix:
    
    % grep -E ID=Vigun[A-Z,0-9,a-z]+.[0-9].v1.2 Vunguiculata_IT97K-499-35_v1.2.cds_primaryTranscriptOnly.fa | awk '{print $5}' | sed 's/ID=//g' | sed 's/v1.2//g' > Primary_chro.txt

To get the Core.bed, Core_CDS.bed, NonCore.bed, and NonCore_CDS.bed [subset_GFF.sh] was used

To calculate the Core_Distance.txt file, I used:
    
    % awk -v OFS='\t' 'BEGIN {OFS="\t"}{print $1,$3-$2,$5}' Core.bed > Core_Distance.txt

  - (This is also the command used to produce other distance results)
  
To get the BED for primary, I used the [Primary_cds.sh]

To compare the Primary_CDS and the core/noncore, I used:
    
    % comm -12 <(sort Core_CDS.bed) <(sort Primary_CDS.bed) > Primary_Core_CDS.bed
  
## **Length Analysis**

### Dependencies:
- Datamash

### Identify unique transcripts by name in cowpea

```bash
% cd /Users/pmorrell/Dropbox/Documents/Sandbox/Cowpea_Pangenome/Core_vs_Noncore/results

#[//]: Find the mean, median, standard deviation, and sum of CDS lengths of NonCore
% sort -k3,3n Primary_NonCore_CDS_Distance.txt | sed -e '/contig_/d' | sort -u | wc -l
% sort -k3,3n Primary_NonCore_CDS_Distance.txt | sed -e '/contig_/d' | sort -u > ~/Desktop/Noncore_uniq_transc.txt
% arr=()
% IFS=$'\n' read -d '' -r -a arr < ~/Desktop/Noncore_uniq_transc.txt
% for i in "${arr[@]}"; do sed -n "/$i/p" NonCore_CDS_Distance.txt | datamash sum 2; done | datamash count 1 mean 1 median 1 sstdev 1 sum 1

#[//]: Find the mean, median, standard deviation, and sum of CDS lengths of Core
% sort -k3,3n Primary_Core_CDS_Distance.txt | sed -e '/contig_/d' | sort -u > ~/Desktop/Core_uniq_transc.txt
% wc -l ~/Desktop/Core_uniq_transc.txt
% IFS=$'\n' read -d '' -r -a arr < ~/Desktop/Core_uniq_transc.txt
% for i in "${arr[@]}"; do sed -n "/$i/p" Core_CDS_Distance.txt | datamash sum 2; done | datamash count 1 mean 1 median 1 sstdev 1 sum 1

```

<br></br>


## **Core Results**
 `Core.bed` 
 * BED file that contains the  coordinate for gene from the reference gff  that are identified as core    
 * This file is generated by comparing  list of "core" gene id to the gff file  and extract the ones that they have in common 

 `Core_CDS.bed`
 - BED file that contains the coodinate for cds from the reference gff that are indentifies as core
 - This file is generated by comparing list of "core" gene id to the cds-only-gff file and extract the ones that they have in common

`Core_CDS_Distance.txt`
- TEXT file that contains the length of each cds that are present in the core
- This result is calculated by taking the difference of the ending and starting coordinates from the Core_CDS.bed file

`Core_Distance.txt`
- TEXT file that contains the length of each gene that are present in the core
- This result is calculated by taking the difference of the ending and starting coordinates from the Core.bed file
<br></br>


## **NonCore Results**
`NonCore.bed`
- BED file that contains the coodinate for gene from the reference gff that are identified as noncore
- This file is generated by comparing list of "noncore" gene id to the gff file and extract the ones that they have in common

`NonCore_CDS.bed`
- BED file that contains the coodinate for cds from the reference gff that are indentifies as noncore
- This file is generated by comparing list of "noncore" gene id to the cds-only-gff file and extract the ones that they have in common

`NonCore_CDS_Distance.txt`
- TEXT file that contains the length of each cds that are present in the noncore
- This result is calculated by taking the difference of the ending and starting coordinates from the NonCore_CDS.bed file

`NonCore_Distance.txt`
- TEXT file that contains the length of each gene that are present in the noncore
- This result is calculated by taking the difference of the ending and starting coordinates from the NonCore.bed file

<br></br>


## **Primary Results**
`Primary_CDS.bed`
- BED file that contains the coordinate for cds that are only from the primary transcripts
- This file is generated by comparing list of "primary" id to the gff file and extract the ones that they have in common

`Primary_CDS_Distance.txt`
- TEXT file that contains the length of each cds that are present in the primary transcript
- This result is calculated by taking the difference of the ending and starting coordinate from the Primary_CDS.bed file

<br></br>


## **Primary Core Results**
`Primary_Core_CDS.bed`
- BED file that contains the coordinate for cds that are only from the primary transcripts and part of the core 
- This file is generated by comparing the Primary_CDS.bed with the Core.bed to find the common among the two files
  
`Primary_Core_CDS_Distance.txt`
- TEXT file that contains the length of each core cds that are present in the primary transcripts
- This result is calculated by taking the difference of the ending and starting coordinate from the Primary_Core_CDS.bed

<br></br>


## **Primary NonCore Results**
`Primary_NonCore_CDS_Distance.txt`	
- TEXT file that contains the length of each noncore cds that are present in the primary transcripts
- This result is calculated by taking the difference of the ending the starting coordinate from the Primary_NonCore_CDS.bed

`Primary_Noncore_CDS.bed`	
- BED file that contains the coordinate for cds that are only from the primary transcripts and part of the noncore
- This file is generated by comparing the Primary_CDS.bed with the NonCore.bed to find the common among the two files


[//]: # (Reference links)
[primary_cds.sh]: (https://github.com/MorrellLAB/Cowpea_Pangenome/blob/main/Core_vs_Noncore/scripts/primary_cds.sh) "primary_cds.sh"
[subset_GFF.sh]: (https://github.com/MorrellLAB/Cowpea_Pangenome/blob/main/Core_vs_Noncore/scripts/subset_GFF.py) "subset_GFF.sh"
