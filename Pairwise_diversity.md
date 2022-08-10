06 August 2022 \
Peter L. Morrell \
Falcon Heights, MN

# Pairwise diversity estimates for cowpea

## Code block below from Stefano Lonardi used for generating callable regions bed file

```bash
#===
export DIR=0.Ref
export SAMPLE=cowpeaA.realigned
export MOSDEPTH_Q0=zero # 0 -- defined by the arguments to --quantize
export MOSDEPTH_Q1=low  # 1..4
export MOSDEPTH_Q2=yes  # 5..400  average coverage is 200x
export MOSDEPTH_Q3=high # 400 ...
mosdepth -t 40 -n --fast-mode -b $DIR.bed --quantize 0:1:5:400: $DIR.$SAMPLE.quantized panSNPs/$DIR/$SAMPLE.bam
grep "yes" 0.Ref.cowpeaA.realigned.quantized.quantized.bed > 0.Ref.cowpeaA.realigned.yes.bed

#===
export REF=Cowpea_Genome_1.0.fasta
export DIR=0.Ref
export SAMPLE=$DIR\_combined_allsites
export CHR=Vu01

sudo pigz -d panSNPs/$DIR/combined.g.vcf.gz
sudo pigz -d panSNPs/$DIR/$REF
sudo samtools faidx panSNPs/$DIR/$REF
sudo /home/qliang/0.soft/GATK/gatk/gatk IndexFeatureFile -I panSNPs/$DIR/combined.g.vcf

/home/qliang/0.soft/GATK/gatk/gatk --java-options "-Xmx32g" GenotypeGVCFs \
--allow-old-rms-mapping-quality-annotation-data \
-R panSNPs/$DIR/$REF \
-V panSNPs/$DIR/combined.g.vcf \
-all-sites \
-L $CHR \
-O $SAMPLE$CHR.g.vcf

bgzip $SAMPLE$CHR.g.vcf
tabix $SAMPLE$CHR.g.vcf.gz
pixy --stats pi \
     --vcf $SAMPLE$CHR.g.vcf.gz \
     --populations $DIR.txt \
     --bypass_invariant_check 'yes' \
     --bed_file $DIR.cowpeaA.realigned.yes.bed \
     --n_cores 40 \
     --chromosomes $CHR

mv pixy_pi.txt $CHR.pixy_pi.txt
===
```

## Using [pixy](https://pixy.readthedocs.io/en/latest/) output from Stefano Lonardi
```bash
cd /Users/pmorrell/Desktop/pixy_callable_regions
[//]: Calculate diversity for all the pixy output
for i in *.txt; do echo $i; sed '/NA/d' $i | datamash --headers mean 5 sstdev 5; done
[//]: Calculate diversity for all chromosomes simultaneously
for i in *.txt; do echo $i; sed '/NA/d' $i | datamash -R 4 --headers mean 5 sstdev 5; done
sed '/pop/d' temp.txt| sed '/NA/d' | datamash -R 4 mean 5 sstdev 5
```
