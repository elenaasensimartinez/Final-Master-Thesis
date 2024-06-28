#!/bin/bash
#SBATCH -J roh_e #job name
#SBATCH -q vlong #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu=10G
#SBATCH -o ROH_eastern_lowland_%a.out #STDOUT
#SBATCH -e ROH_eastern_lowland_%a.err #STDERR

module purge
module load BCFtools/1.17-GCC-12.2.0


sample="/scratch_isilon/groups/compgen/easensi/heterozygosity/list_ids_eastern_lowland" #path to list with ids of the subset of individuals
IN="/scratch_isilon/groups/compgen/easensi/Captive_TFM/vcf_filter_miss_depth/def_filter" #path to folder where merged VCF file is
OUT="/scratch_isilon/groups/compgen/easensi/ROH/def_eastern_lowland" #path to saving folder

                                                        ### RoH analysis ###
bcftools roh -s ${sample} ${IN}/merged_def_filter_vcf.gz -G30 -e GT,- -o ${OUT}/${sample}_ROH_eastern
