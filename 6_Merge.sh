#!/bin/bash
#SBATCH -J MergeBam #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o Mergebam_%a.out #STDOUT
#SBATCH -e Mergebam_%a.err #STDERR
#SBATCH -a 1-3 #array number

module purge
module load SAMtools/1.15-GCC-11.2.0

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FilterInsertSize_2/filtered_names" #path to fastqs

fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam"; mkdir -p $OUT #path to saving folder
bamlist="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FilterInsertSize_2/" #path to BAM files list

samtools merge - ${bamlist}*${fastq}_filtered.bam | samtools view -hb > ${OUT}/${fastq}_merged.bam #merging BAM files according to sample
