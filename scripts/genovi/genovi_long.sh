#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=genovi_long
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source ~/.bashrc
conda activate genovi_env

OUTDIR=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/genovi/
mkdir -p "$OUTDIR"
cd "$OUTDIR"

genovi \
  -i /gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/annotations/long/PROKKA_01302026.gbk \
  -s draft \
  -cu \
  -o genovi_long

