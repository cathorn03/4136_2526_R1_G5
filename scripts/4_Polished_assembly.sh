#!/bin/bash
#SBATCH --job-name=polished_assembly
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=256g
#SBATCH --time=24:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use
conda activate assemblies #Activates assemblies env

cd ./assmeblies #Enters long reads folder

READS=../short_reads/merged_sr.fastq.gz
ASSEMBLY=./long/assembly.fastq
#Creates variables for polishing

minimap2 -a -t 16 $ASSEMBLY $READS > short_vs_L_assembly.sam #Creates sam file with sequence overlaps
OVERLAPS=./short_vs_L_assembly.sam #Sets ads a variable for Racon

cd ../assemblies/long #Enters long_read assembly output directory.

racon -t 16 -m 8 -x -6 -g -8 -w 500 $READS $OVERLAPS $ASSEMBLY > polished.fasta #Runs racon
fold -b -w 60 polished.fasta > ml_polished.fasta #Formats reads to be multiline

conda deactivate #Deactivates this env