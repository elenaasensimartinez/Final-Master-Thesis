#!/bin/bash
#SBATCH -J concat #job name
#SBATCH -q vlong
#SBATCH -c 4
#SBATCH --mem-per-cpu 40G


module purge
module load BCFtools/1.17-GCC-12.2.0

bcftools concat -f vcf_file.txt -Oz  > merged_vcf_filter.vcf.gz
