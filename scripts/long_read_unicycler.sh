#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --job-name=long_read_unicycler
#SBATCH --mem=256g
#SBATCH --time=48:00:00
#SBATCH --mail-user=mbyct9@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda us

conda activate unicycler #activates conda enviroment

LONG=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/nanopore/merged_barcode05.fastq.gz

#^Sets file locations

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/long_read_assembly/

#^ Sets output

unicycler -l $LONG -o $OUT --threads 20
#Runs unicycler

