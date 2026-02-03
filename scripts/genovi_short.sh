#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=genovi_short
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --mail-user=mbxas28@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile

conda activate genovi_env

genovi \
  -i /gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/prokka/short/PROKKA_02022026.gbk \
  -s draft \
  -cu \
  -o /gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/genovi/genovi_short
