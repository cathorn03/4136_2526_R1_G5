#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=polishing
#SBATCH --mem=128g
#SBATCH --time=01:00:00
#SBATCH --mail-user=mbyct9@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile

conda activate polish

cd /gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/nanopore

READS=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/illumina/merged_illumina.fastq.gz
ASSEMBLY=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/long_read/assembly.fasta

minimap2 -a -t 16 $ASSEMBLY $READS > short_vs_assembly.sam

OVERLAPS=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/nanopore/short_vs_assembly.sam

cd /gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/long_read/

racon -t 16 -m 8 -x -6 -g -8 -w 500 $READS $OVERLAPS $ASSEMBLY > short_polished.fasta

fold -b -w 60 short_polished.fasta > ml_polished.fasta

conda deactivate

