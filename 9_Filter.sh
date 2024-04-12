#!/bin/bash
#SBATCH -J Filter #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o Filter_%a.out #STDOUT
#SBATCH -e Filter_%a.err #STDERR
#SBATCH -a 1-3 #number of samples

module purge; 
module load SAMtools/1.15-GCC-11.2.0 

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam/samples_ids"

fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Filter"; mkdir -p $OUT
bam="/scratch_isilon/groups/compgen/easensi/Captive_TFM/RemoveDuplicates"

samtools view -h -bq 30 -F 256 -F 4 ${bam}/${fastq}_remove_duplicates.bam > ${OUT}/${fastq}_filtered_2.bam; samtools index ${OUT}/${fastq}_filtered_2.bam
