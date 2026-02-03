#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=genovi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile

conda activate genovi_env

GBK=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/prokka/PROKKA_01302026.gbk
OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/genovi/genovi_long

genovi -i $GBK -s draft -cu -o $OUT
