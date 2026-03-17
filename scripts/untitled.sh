#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=vcf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --mem=20g
#SBATCH --time=12:00:00
#SBATCH --mail-user=mbyct9@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use
conda activate vcf #Activates vcf env

cd ./long_reads/

REF=../reference/genome.fna
FASTQ=merged_lr.fastq.gz

minimap2 -a -x map-ont $REF $FASTQ > alignment.sam

samtools sort -o alignment.sorted.bam alignment.sam
samtools index alignment.sorted.bam

cd ../

