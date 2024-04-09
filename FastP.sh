#!/bin/bash
#SBATCH -J TRIM #job name
#SBATCH -q normal #maximum limits available for the job 
#SBATCH -c 1 #cpu per task
#SBATCH --mem 50G #memory pool for all cores MB
#SBATCH -o FASTP_%a.out #STDOUT
#SBATCH -e FASTP_%a.err #STDERR
#SBATCH -a 1-44 #number of samples

module purge
module load fastp/0.23.2-GCC-11.3.0 
path_list_fastq="/scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/CGLILLUMINA_34/fastqs"
fastq=$(awk -v line=“$SLURM_ARRAY_TASK_ID” ‘NR==line {print $0}’ ${path_list_fastq})

DIR=“scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/”
IN=${DIR}”CGLILLUMINA_34/”

OUT=“scratch_isilon/groups/compgen/easensi/Captive_TFM/FastP_trim/”; mkdir -p $OUT
p1=${IN}${fastq}_1.fastq.gz
p2=${IN}${fastq}_2.fastq.gz
out_1=${OUT}${fastq}_trimmed_1.fastq.gz
out_2=${OUT}${fastq}_trimmed_2.fastq.gz
json=${OUT}${fastq}.fastp.json

fastp -i ${p1} -I ${p2} --out1 ${out_1} --out2 ${out_2} --detect_adapter_for_pe -p --
adapter_sequence=AGATCGGAAGAGCACACGTCTGAACTCCAGTCA --
adapter_sequence_r2=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT --trim_poly_g --poly_g_min_len 10 --
length_required 30 --json ${json} --html ${OUT}${fastq}.html
