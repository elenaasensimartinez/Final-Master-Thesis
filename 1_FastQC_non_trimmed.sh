#!/bin/bash
#SBATCH -J Fastqc #job name
#SBATCH -q normal #maximum limits available for the job
#SBATCH -c 1 #cpu per task
#SBATCH --mem 8G #memory pool for all cores MB
#SBATCH -o Fastqc_not_trimmed_%a.out #STDOUT
#SBATCH -e Fastqc_not_trimmed_%a.err #STDERR
#SBATCH -a 1-44 #array number

module purge
module load FastQC/0.11.9-Java-11

path_list_fastq="/scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/CGLILLUMINA_34/fastqs" #path to different fastqs
fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
IN="/scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/CGLILLUMINA_34/"
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FastQC_non_trimmed"; mkdir -p $OUT #path to saving folder
p1=${IN}${fastq}_1.fastq.gz
p2=${IN}${fastq}_2.fastq.gz

fastqc -f fastq $p1 $p2 --outdir=$OUT #fastqc analysis
