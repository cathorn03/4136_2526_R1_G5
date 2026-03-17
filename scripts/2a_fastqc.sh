#!/bin/bash
#SBATCH --job-name=fastqc
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

source $HOME/.bash_profile #Allows conda use
conda activate QC  #activates the QC env

mkdir QC
mkdir QC/short

cd QC/short

R1_FASTQ=../../short_reads/merged_sr_R1.fastq.gz
R2_FASTQ=../../short_reads/merged_sr_R2.fastq.gz
mg_FASTQ=../../short_reads/merged_sr.fastq.gz

fastqc -o ./ $R1_FASTQ
fastqc -o ./ $R2_FASTQ
fastqc -o ./ $mg_FASTQ