#!/bin/bash
#SBATCH -J MAPPING #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o Mapping_%a.out #STDOUT
#SBATCH -e Mapping_%a.err #STDERR
#SBATCH -a 1-44 #number of samples
module purge
module load BWA/0.7.17-foss-2018b
module load SAMtools/1.15-GCC-11.2.0
path_list_fastq="/scratch_isilon/groups/compgen/iruiz/EEP_gorillas/FTAcards_Hairs/FASTQ/CGLILLUMINA_34/fastqs"
fastq=$(awk -v line=&quot;$SLURM_ARRAY_TASK_ID&quot; &#39;NR==line {print $0}&#39; ${path_list_fastq})

IN="/scratch_isilon/groups/compgen/easensi/Captive_TFM/FastP_trim"
IN_2="/scratch/devel/malvarest/refs/GRCh38"

fastq_1=${IN}/${fastq}_trimmed_1.fastq.gz
fastq_2=${IN}/${fastq}_trimmed_2.fastq.gz
ref=${IN_2}/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna

OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Mapping_bam/"; mkdir -p $OUT

bwa mem -t 4 -M $ref $fastq_1 $fastq_2 | samtools view -Sbhu | samtools sort - -T ${fastq} -@ 8 -o ${OUT}${fastq}.bam
