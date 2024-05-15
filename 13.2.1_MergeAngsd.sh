#!/bin/bash
#SBATCH -J mergeangsd #job name
#SBATCH -q normal #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu 30G #memory pool for all cores MB
#SBATCH -o MergeAngsd.out #STDOUT
#SBATCH -e MergeAngsd.err #STDERR

chromfile="/scratch_isilon/groups/compgen/easensi/NGS_relate/western_lowland"
out="/scratch_isilon/groups/compgen/easensi/NGS_relate/western_lowland/merged_western_lowland_relate.gz"
for CHR in `seq 2 24`
do
  gunzip -c ${chromfile}/chr${CHR}_western_lowland_genolike.glf.gz | gzip -c
done >> ${out}
