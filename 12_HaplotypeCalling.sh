#!/bin/bash
#SBATCH -J HapCall #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 150G #memory pool for all cores MB
#SBATCH -o HapCall_def_%a.out #STDOUT
#SBATCH -e HapCall_def_%a.err #STDERR
#SBATCH -a 1-24 #array number
module purge
module load GATK/4.2.5.0-GCCcore-11.2.0-Java-11

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/samples_for_vcf" #path to the file with the ids for samples that undergo haplotye calling
path_list_chrom="/scratch_isilon/groups/compgen/easensi/Captive_TFM/chromosomes" #path to the file with the chromosome identifiers
bam="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Filter" #path to the BAM files folder 
ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" #path to the reference genome
vcf="/scratch_isilon/groups/compgen/easensi/Captive_TFM/HaplotypeCalling_2"; mkdir -p $vcf #path to saving folder
samples=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_chrom}) 

for i in "${samples[@]}"; do
  while IFS= read -r fastq; do #Loop for each fastq
  gatk HaplotypeCaller -I ${bam}/${fastq}_filtered_2.bam -O ${vcf}/${fastq}_${i}.vcf.gz -R $ref --L ${i} --ERC BP_RESOLUTION #haplotype calling procedure
  done < "${path_list_fastq}"
done
