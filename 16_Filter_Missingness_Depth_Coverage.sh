#!/bin/bash
#BATCH -J MissingnessDepth #job name
#SBATCH -q vlong #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu 40G #memory pool for all cores MB
#SBATCH -o Missingness_Depth_%a.out #STDOUT
#SBATCH -e Missingness_Depth_%a.err #STDERR
#SBATCH -a 1-24

module purge
module load BCFtools/1.17-GCC-12.2.0
module load VCFtools/0.1.16-GCC-11.2.0
module load HTSlib/1.17-GCC-12.2.0

vcf="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Variant_Calling_def107"
vcf_indels="/scratch_isilon/groups/compgen/easensi/Captive_TFM/vcf_filter_miss_depth"
path_list_chrom="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergeGVCFs/chromfile"
samples=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_chrom})

bcftools filter -e 'F_MISSING > 0.2' ${vcf}/${samples}_variantcall_def107.vcf.gz | vcftools --gzvcf - --minDP 10 --maxDP 13 --minGQ 30 --recode --stdout | bcftools filter -e \"TYPE!='indels'\" -o ${vcf_indels}/${samples}_filter_miss_depth.vcf.gz
