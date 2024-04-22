#!/bin/bash
#SBATCH -J MergeGVCFs #job name
#SBATCH -q vlong #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 150G #memory pool for all cores MB
#SBATCH -o MergeGVCFs_sec_%a.out #STDOUT
#SBATCH -e MergeGVCFs_sec_%a.err #STDERR
#SBATCH -a 1-24

module purge
module load GATK/4.2.5.0-GCCcore-11.2.0-Java-11

OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergeGVCFs_sec"; mkdir -p $OUT
ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna"
path_list_list="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Script14_combine"
path_list_chrom="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Script14_combine/chromfile"
samples=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_chrom}) #extraction of the chromosome name


 gatk CombineGVCFs  -R ${ref}  --variant ${path_list_list}/List_${samples}.list -O ${OUT}/${samples}_sec_combined.vcf.gz
