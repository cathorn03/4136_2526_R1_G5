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

SHORT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/short_read/assembly.fasta
LONG=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/long_read/assembly.fasta
HYBRID=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/hybrid/assembly.fasta
POLISHED=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/long_read/polished.fasta

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/quast
REF=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/reference/genome.fna
FET=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/reference/anotated.gff

quast $SHORT $LONG $HYBRID $POLISHED -o $OUT -r $REF -g $FET
