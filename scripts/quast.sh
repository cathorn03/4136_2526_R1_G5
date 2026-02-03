#!/bin/bash
#SBATCH --partition=defq
#SBATCH --job-name=quast
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=16g
#SBATCH --time=1:00:00
#SBATCH --mail-user=mbyct9@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile

conda activate quast

FILE1=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/short_read_assembly/assembly.fasta
FILE2=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/long_read_assembly/assembly.fasta
FILE3=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/hybrid_assembly/assembly.fasta

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/quast
REF=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/reference/genome.fna
FET=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/reference/anotated.gff

quast $FILE1 $FILE2 $FILE3 -o $OUT -r $REF -g $FET
