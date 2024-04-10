#!/bin/bash
#SBATCH -J AddReadGroup #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o AddReadGroup_%a.out #STDOUT
#SBATCH -e AddReadGroup_%a.err #STDERR
#SBATCH -a 1-3 #number of samples

module purge
module load Java/15.0.1
module load picard/2.26.10-Java-15 

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam/samples_ids"

fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/AddReadGroup"; mkdir -p $OUT
bam="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam/"

java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups -I ${bam}${fastq}_merged.bam -O ${OUT}/${fastq}_add_read_group.bam -SORT_ORDER coordinate -QUIET TRUE -COMPRESSION_LEVEL 9 -MAX_RECORDS_IN_RAM 150000 -RGLB ${fastq} -RGPL Illumina -RGPU gorilla -RGSM ${fastq} -VALIDATION_STRINGENCY SILENT
