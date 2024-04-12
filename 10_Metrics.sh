#!/bin/bash
#SBATCH -J Metrics #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o Metrics_%a.out #STDOUT
#SBATCH -e Metrics_%a.err #STDERR
#SBATCH -a 1-3 #number of samples

module purge
module load Java/15.0.1
module load picard/2.26.10-Java-15

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam/samples_ids"

fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Metrics"; mkdir -p $OUT
bam_merged="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergedBam"
bam_rmdups="/scratch_isilon/groups/compgen/easensi/Captive_TFM/RemoveDuplicates"
bam_filtered="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Filter"
ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna"

java -jar $EBROOTPICARD/picard.jar CollectAlignmentSummaryMetrics -I ${bam_merged}/${fastq}_merged.bam -O ${OUT}/${fastq}_merged_metrics.txt -R ${ref} -VALIDATION_STRINGENCY SILENT
java -jar $EBROOTPICARD/picard.jar CollectAlignmentSummaryMetrics -I ${bam_rmdups}/${fastq}_remove_duplicates.bam -O ${OUT}/${fastq}_duplicates_metrics.txt -R ${ref} -VALIDATION_STRINGENCY SILENT
java -jar $EBROOTPICARD/picard.jar CollectAlignmentSummaryMetrics -I ${bam_filtered}/${fastq}_filtered_2.bam -O ${OUT}/${fastq}_filter_metrics.txt -R ${ref} -VALIDATION_STRINGENCY SILENT
