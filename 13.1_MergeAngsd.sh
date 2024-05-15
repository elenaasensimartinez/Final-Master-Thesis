#!/bin/bash
#SBATCH -J mergeangsd #job name
#SBATCH -q normal #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu 30G #memory pool for all cores MB
#SBATCH -o MergeAngsd.out #STDOUT
#SBATCH -e MergeAngsd.err #STDERR

chromfile="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Geno_likelihood_def/benfets"
out="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Geno_likelihood_def/benfets/merged_output.beagle.gz"
for CHR in `seq 2 24`
do
  gunzip -c ${chromfile}/chr${CHR}_final_captive.genolike.beagle.gz | sed 1d | gzip -c
done >> ${out}
