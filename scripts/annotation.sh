#!/bin/bash
#SBATCH --job-name=annotation
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=256g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use
conda activate annotation #Activates annotation env

mkdir annotations #Creates output directory
cd annotations #Enters the directory

OUT=./short_reads/
FILE=../assemblies/short_reads/assembly.fasta
prokka --kingdom Archaea --outdir $OUT $FILE


OUT=./long_reads/
FILE=../assemblies/long_reads/assembly.fasta
prokka --kingdom Archaea --outdir $OUT $FILE


OUT=./hybrid/
FILE=../assemblies/hybrid/assembly.fasta
prokka --kingdom Archaea --outdir $OUT $FILE


OUT=./polished/
FILE=../assemblies/long_reads/ml_polished.fasta
prokka --kingdom Archaea --outdir $OUT $FILE
#Runs Prokka for each of the assemblies.

conda deactivate #Deactivates conda