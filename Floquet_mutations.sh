#!/bin/bash
#SBATCH -J floquet #job name
#SBATCH -q short #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu 10G #memory pool for all cores MB

module purge
module load BCFtools/1.17-GCC-12.2.0 

                  ### extraction of exact position, using hg38 reference genome, for all samples with coverage >5X ###
bcftools view -r chr5:33944689 chr5_variantcall_def107.vcf.gz -Ou | bcftools query -f '%CHROM\t%POS\t[%SAMPLE=%GT]\n' > floquet.txt
