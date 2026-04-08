#!/bin/bash
#SBATCH --job-name=read_merge
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=5g
#SBATCH --time=1:00:00
#SBATCH --mail-user=XXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

cd ./long_reads #Enters long reads folder

cat ./*.fastq.gz > merged_lr.fastq.gz #Merges long reads together

cd ../short_reads #Enters short reads folder

cat *R1*.fastq.gz > merged_sr_R1.fastq.gz #Merges forward reads
cat *R2*.fastq.gz > merged_sr_R2.fastq.gz #Merges reverse reads
cat *.fastq.gz > merged_sr.fastq.gz #Merges all reads