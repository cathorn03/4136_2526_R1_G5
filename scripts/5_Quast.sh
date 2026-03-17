#!/bin/bash
#SBATCH --job-name=quast
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32g
#SBATCH --time=24:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use
conda activate assemblies #Activates assemblies env

mkdir quast 

SHORT=./assemblies/short/assembly.fasta
LONG=./assemblies/long/assembly.fasta
HYBRID=./assemblies/hybrid/assembly.fasta
POLISHED=./assemblies/long/ml_polished.fasta

OUT=./quast
REF=./reference/genome.fna
FET=./reference/anotated.gff
#Sets variables for quast

quast $SHORT $LONG $HYBRID $POLISHED -o $OUT -r $REF -g $FET
#Runs quast

conda deactivate