#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --job-name=short_read_unicycler
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

SHORT_F=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/illumina/merged_illumina_forward.fastq.gz
SHORT_R=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/illumina/merged_illumina_reverse.fastq.gz

#^Sets file locations

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/assembly/hybrid_assembly/

#^ Sets output

unicycler -1 $SHORT_F -2 $SHORT_R -o $OUT --threads 20
#Runs unicycler

