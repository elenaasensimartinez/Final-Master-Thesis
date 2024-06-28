#!/bin/bash
#SBATCH -J missingness
#SBATCH -q vlong #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu=20G #memory per CPU
#SBATCH -o site_missingness.out #STDOUT
#SBATCH -e site_missingness.err #STDERR


module purge
module load VCFtools/0.1.16-GCC-11.2.0

                                        ### merged VCF with all samples and chromosomes ###
merged_vcf="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Variant_Calling_def107/non_filtered_merged_vcf_filter.vcf.gz"

                                          ### calculation of missingness per sample ####
vcftools --gzvcf $merged_vcf  --missing-indv --out missingness_non_filtered_vcftools
