#!/bin/bash
#BATCH -J VariantCall #job name
#SBATCH -q vlong #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu 40G #memory pool for all cores MB
#SBATCH -o VariantCalling_%a.out #STDOUT
#SBATCH -e VariantCalling_%a.err #STDERR
#SBATCH -a 1-22 #array number

ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" #path to reference genome
vcf="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergeGVCFs" #path to merged VCFs
vcf_out="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Variant_Calling"; mkdir -p $vcf_out #path to saving folder
path_list_chrom="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergeGVCFs/chromfile" #path to chromosome file
samples=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_chrom}) 

module purge
module load GATK/4.2.5.0-GCCcore-11.2.0-Java-11;

                                                        ### Variant Calling procedure ###
gatk GenotypeGVCFs --include-non-variant-sites -R ${ref} --variant ${vcf}/${samples}_combined.vcf.gz -O ${vcf_out}/${samples}_variantcall.vcf.gz
