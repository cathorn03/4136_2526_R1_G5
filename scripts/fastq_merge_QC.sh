#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=fastq_merge_QC
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

cd ./long_reads #Enters long reads folder

cat *.fastq > merged_lr.fastq

cd ../short_reads

cat *R1*.fastq > merged_sr_R1.fastq
cat *R2*.fastq > merged_sr_R2.fastq
cat *.fastq > merged_sr.fastq

cd ../
mkdir QC
mkdir QC/FastQC
mkdir QC/Nanoplot
cd QC/FastQC

fastqc ../../short_reads/merged_sr_R1.fastq
fastqc ../../short_reads/merged_sr_R2.fastq
fastqc ../../short_reads/merged_sr.fastq

cd ../Nanoplot
source $HOME/.bash_profile #Allows conda use
conda activate groupwork #activates the groupwork env

FASTQ=../../long_reads/merged_lr.fastq
OUT=./

NanoPlot --fastq $FASTQ --plots hex dot -o $OUT

conda deactivate