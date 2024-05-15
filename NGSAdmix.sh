#!/bin/bash
#SBATCH -J rr1_all #job name
#SBATCH -q marathon  #maximum limits available for the job
#SBATCH -c 5 #cpu per task
#SBATCH --mem-per-cpu 45G #memory pool for all cores MB
#SBATCH -e ngsadmix_def_%a_rerun1.err
#SBATCH -o ngsadmix_def_%a_rerun1.out
#SBATCH -a 1-6

seq="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Downsampling_bams/merged_downsampled_output.beagle.gz"
kfile="/scratch_isilon/groups/compgen/easensi/NGS_Admix/NGSadmix/k_file.txt"
Ks=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${kfile})

./NGSadmix -likes ${seq} -K ${Ks} -o NGSadmix_K${Ks}_rerun1 -minMaf 0.004 -seed 1 -tol 0.00005 
