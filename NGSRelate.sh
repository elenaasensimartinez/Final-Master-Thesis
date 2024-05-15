#!/bin/bash
#SBATCH -q eternal 
#SBATCH -c 6 #cpu per task
#SBATCH --mem-per-cpu=40G

module purge
module load OpenSSL
module load Python/3.10.8-GCCcore-12.2.0

/home/groups/compgen/jprado/bin/ngsRelate/ngsRelate -g merged_western_lowland_relate.gz -n 187 -f freq_merged -O marathon_ngs_western_lowland
