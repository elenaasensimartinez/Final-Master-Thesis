#!/bin/bash
#SBATCH -J RemoveDuplicates #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o RemoveDuplicates_%a.out #STDOUT
#SBATCH -e RemoveDuplicates_%a.err #STDERR
#SBATCH -a 1-3 #number of samples

module purge; module load Java/15.0.1; module load picard/2.26.10-Java-15 

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam/samples_ids"

fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/RemoveDuplicates"; mkdir -p $OUT
bam="/scratch_isilon/groups/compgen/easensi/Captive_TFM/AddReadGroup"

java -jar $EBROOTPICARD/picard.jar MarkDuplicates -I ${bam}/${fastq}_add_read_group.bam -O ${OUT}/${fastq}_remove_duplicates.bam -MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 1000 -METRICS_FILE ${OUT}/${fastq}_stats.txt -REMOVE_DUPLICATES true -ASSUME_SORTED true -MAX_RECORDS_IN_RAM 1500000 -VALIDATION_STRINGENCY SILENT -CREATE_INDEX true -COMPRESSION_LEVEL 9
