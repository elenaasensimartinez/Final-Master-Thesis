#!/bin/bash
#SBATCH -J PCA #job name
#SBATCH -q short #maximum limits available for the job
#SBATCH -c 2 #cpu per task
#SBATCH --mem 50G #memory pool for all cores MB
#SBATCH -o PCA.out #STDOUT
#SBATCH -e PCA.err #STDERR

inputbeaglegz="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Downsampling_bams/merged_downsampled_output.beagle.gz" #path to merged beagle file
OUT="/scratch_isilon/groups/compgen/easensi/Captive_TFM/PCA_all"; mkdir -p $OUT #path to saving folder
pcangsd="${OUT}/pcangsd"

module purge
module load angsd/0.935-GCC-10.2.0
module load Python/3.10.8-GCCcore-12.2.0

                        ### PCA analysis ###
pip3 install --user -r ~easensi/bin/pcangsd_folder/requirements.txt
~easensi/bin/pcangsd -b ${inputbeaglegz} -o ${pcangsd}
