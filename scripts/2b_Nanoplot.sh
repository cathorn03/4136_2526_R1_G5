#!/bin/bash
#SBATCH --job-name=nanoplot
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
mkdir QC/NanoPlot
cd QC/NanoPlot

lr_FASTQ=../../long_reads/merged_lr.fastq.gz

NanoPlot --fastq $lr_FASTQ --plots hex dot -o ./ #Runs nanoplot