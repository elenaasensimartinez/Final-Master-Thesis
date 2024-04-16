#!/bin/bash
#SBATCH -J Angsd #job name
#SBATCH -q long #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem 150G #memory pool for all cores MB
#SBATCH -o Angsd_%a.out #STDOUT
#SBATCH -e Angsd_%a.err #STDERR


module purge
module load OpenSSL
module load angsd/0.935-GCC-10.2.0

bamfilelist="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Listfile" #path to the bam files folder 
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Geno_likelihood/"; mkdir -p $OUT
genolike="${OUT}final_captive.genolike"
ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna"

angsd -GL 2 -out ${genolike} -nThreads 10 -doGlf 2 -doMajorMinor 1 -doMaf 1 -r chr21: -SNP_pval 1e-6 -bam "${bamfilelist}" -ref ${ref} -trim 0 -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -baq 1 -skipTriallelic 1 -minMapQ 25 -minQ 20 -minMaf 0.004 #depends on the number of samples and the population
