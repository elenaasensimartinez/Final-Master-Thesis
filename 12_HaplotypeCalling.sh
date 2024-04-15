#!/bin/bash
#SBATCH -J HapCall #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 100G #memory pool for all cores MB
#SBATCH -o HapCall_%a.out #STDOUT
#SBATCH -e HapCall_%a.err #STDERR
#SBATCH -a 1-2 #number of samples

module purge
module load GATK/4.2.5.0-GCCcore-11.2.0-Java-11

path_list_fastq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/samples_for_vcf" #path to the file with the ids for samples that undergo haplotye calling
chrom="/scratch_isilon/groups/compgen/easensi/Captive_TFM/chromosomes" #path to the file with the chromosome identifiers
bam="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Filter" #path to the bam files folder 
ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" #path to the reference genome
vcf="/scratch_isilon/groups/compgen/easensi/Captive_TFM/HaplotypeCalling"; mkdir -p $vcf #path and creation of the folder where the VCF will be saved

for SLURM_ARRAY_TASK_ID in $(seq $SLURM_ARRAY_TASK_MIN $SLURM_ARRAY_TASK_MAX); do
fastq=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_fastq}) #extraction of the sample name

while IFS= read -r i; do #construct -L option for all the genomic intervals for each sample
intervals+=" --L ${i}"
done < "${chrom}"

gatk HaplotypeCaller -I ${bam}/${fastq}_filtered_2.bam -O ${vcf}/${fastq}.vcf.gz -R $ref ${intervals} --ERC BP_RESOLUTION
done
