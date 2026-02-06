#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --job-name=hybrid_prokka
#SBATCH --mem=16g
#SBATCH --time=48:00:00
#SBATCH --mail-user=mbyct9@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile

conda activate prokka

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/annotations/hybrid/
FILE=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/hybrid/assembly.fasta

prokka --kingdom Archaea --outdir $OUT $FILE
