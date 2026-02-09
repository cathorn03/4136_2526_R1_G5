#!/bin/bash
#SBATCH --job-name=fastq_merge_QC
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

cd ./long_reads #Enters long reads folder

cat *.fastq.gz > merged_lr.fastq.gz #Merges long reads together

lr_FASTQ=merged_lr.fastq.gz
#Creates variable for NanoPlot

cd ../short_reads #Enters short reads folder

cat *R1*.fastq.gz > merged_sr_R1.fastq.gz #Merges forward reads
cat *R2*.fastq.gz > merged_sr_R2.fastq.gz #Merges reverse reads
cat *.fastq > merged_sr.fastq.gz #Merges all reads

R1_FASTQ=merged_sr_R1.fastq.gz
R2_FASTQ=merged_sr_R2.fastq.gz
sr_FASTQ=merged_sr.fastq.gz
#Creates variables for FastQC

cd ../ #Enters working folder

mkdir QC
mkdir QC/FastQC
mkdir QC/NanoPlot
#Makes directories for the QC outputs

cd QC/FastQC #Enters output folder for fastqc

fastqc -o ./ $R1_FASTQ
fastqc -o ./ $R2_FASTQ
fastqc -o ./ $sr_FASTQ
#Runs FastQC on all short reads

cd ../NanoPlot #Enters output folder for naoplot

source $HOME/.bash_profile #Allows conda use
conda activate QC  #activates the QC env

NanoPlot --fastq $lr_FASTQ --plots hex dot -o ./ #Runs nanoplot

conda deactivate #Deactivates env
