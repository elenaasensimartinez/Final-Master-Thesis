#!/bin/bash
#BATCH -J Western_Lowland #job name
#SBATCH -q marathon #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu=37G #memory per CPU
#SBATCH -o 2_Angsd_for_western_lowland_%a.out #STDOUT
#SBATCH -e 2_Angsd_for_western_lowland_%a.err #STDERR
#SBATCH -a 1-24 #array number

module purge
module load OpenSSL
module load angsd/0.935-GCC-10.2.0

list="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Downsampling_bams/western_lowland_downsampled.txt" #path to a file containing downsampled BAM files paths
out="/scratch_isilon/groups/compgen/easensi/pcangsd" #path to saving folder
path_list_chrom="/scratch_isilon/groups/compgen/easensi/Captive_TFM/MergeGVCFs/chromfile"
samples=$(awk -v line="$SLURM_ARRAY_TASK_ID" 'NR==line {print $0}' ${path_list_chrom}) 
ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" #path to reference genome

                                                    ### obtention of beagle binary file ###
angsd -b ${list}  -gl 2 -domajorminor 1 -snp_pval 1e-6 -domaf 1 -minmaf 0.004 -doGlf 3 -r ${samples}:  -out ${out}/${samples}_western_lowland_genolike 
