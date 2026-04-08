#!/bin/bash
#SBATCH --job-name=quast
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32g
#SBATCH --time=01:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use
conda activate quast #Activates quast env

mkdir quast 

SHORT=./assemblies/short/assembly.fasta
LONG=./assemblies/long/assembly.fasta
HYBRID=./assemblies/hybrid/assembly.fasta
POLISHED=./assemblies/long/ml_polished.fasta

OUT=./quast
REF=./reference/*.fna
FET=./reference/*.gff
#Sets variables for quast

quast $SHORT $LONG $HYBRID $POLISHED -o $OUT -r $REF -g $FET
#Runs quast

conda deactivate