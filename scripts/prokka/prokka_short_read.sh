#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=prokka_short
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16g
#SBATCH --time=1:00:00
#SBATCH --mail-user=mbxas28@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile

conda activate prokka

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/annotation/short/
FILE=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/short_read_assembly/assembly.fasta

prokka --kingdom Archaea --outdir $OUT $FILE
