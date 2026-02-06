#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=genovi_hybrid
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=48:00:00
#SBATCH --mail-user=mbxas28@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile
conda activate test_genovi

OUTDIR=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/genovi/
mkdir -p "$OUTDIR"
cd "$OUTDIR"

FILE=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/annotations/hybrid/PROKKA_02042026.gbk

genovi -t 16 -i $FILE -s complete -o genovi_hybdrid
