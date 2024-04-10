#!/bin/bash
#SBATCH -J Filter #job name
#SBATCH -q normal #maximum limits available for the job
#SBATCH -c 1 #cpu per task
#SBATCH --mem 8G #memory pool for all cores MB
#SBATCH -o Filter_%a.out #STDOUT
#SBATCH -e Filter_%a.err #STDERR
#SBATCH -a 1-44 #number of samples

module purge
module load SAMtools/1.15-GCC-11.2.0

path_list_fastq="/scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/CGLILLUMINA_34/fastqs"

fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})

bamFile="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Mapping_bam_2"
bamIS="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FilterInsertSize_2/"; mkdir -p $OUT

samtools view -h ${bamFile}${fastq}.bam | awk 'substr($0,1,1)=="@" || ($9>= 35) || ($9<=-35)' | samtools view -hb > ${bamIS}${fastq}_filtered.bam ;samtools index ${bamIS}${fastq}_filtered.bam
