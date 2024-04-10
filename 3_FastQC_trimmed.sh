#!/bin/bash
#SBATCH -J Fastqc_trimmed #job name
#SBATCH -q normal #maximum limits available for the job
#SBATCH -c 1 #cpu per task
#SBATCH --mem 8G #memory pool for all cores MB
#SBATCH -o Fastqc_trimmed_%a.out #STDOUT
#SBATCH -e Fastqc_trimmed_%a.err #STDERR
#SBATCH -a 1-44 #number of samples

module purge
module load FastQC/0.11.9-Java-11

path_list_fastq="/scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/CGLILLUMINA_34/fastqs"
fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq})
IN="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FastP_trim/"
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FastQC_trimmed"; mkdir -p $OUT
p1=${IN}${fastq}_trimmed_1.fastq.gz
p2=${IN}${fastq}_trimmed_2.fastq.gz

fastqc -f fastq $p1 $p2 --outdir=$OUT
