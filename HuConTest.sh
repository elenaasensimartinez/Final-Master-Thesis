#!/bin/bash
#BATCH -J Angsd_for_ibd #job name
#SBATCH -q vlong #maximum limits available for the job
#SBATCH -c 4 #cpu per task
#SBATCH --mem-per-cpu=30G #mem per CPU


module purge
module load BCFtools/1.17-GCC-12.2.0
module load SAMtools/1.14-GCC-11.2.0
module load R/4.1.2-foss-2021b

ref="/scratch/devel/malvarest/refs/GRCh38/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna" #path to used reference genome
sample="/scratch_isilon/groups/compgen/easensi/Captive_TFM/Downsampling_bams/MY_SAMPLES/AX7417_downsampling.bam" #path to BAM from one sample
argum="$ref,gorilla,$sample"

                ### HuConTest ###
Rscript --vanilla contamination_test_ape.R ${argum}
