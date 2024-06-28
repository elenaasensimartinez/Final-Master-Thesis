#!/bin/bash
#SBATCH -J concat #job name
#SBATCH -q vlong #running time
#SBATCH -c 4 #number of CPUs
#SBATCH --mem-per-cpu 40G #memory per CPU


module purge
module load BCFtools/1.17-GCC-12.2.0

    ### concat all VCFs for each chromosome into one ###
bcftools concat -f vcf_file.txt -Oz  > merged_vcf_filter.vcf.gz
