#!/bin/bash
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=nanoplot
#SBATCH --mem=5g
#SBATCH --time=01:00:00
#SBATCH --mail-user=mbyct9@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-type=fail
#SBATCH --output=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-outputs/slurm-%x-%j.out
#SBATCH --error=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use

conda activate groupwork #activates the groupwork env

FASTQ=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/nanopore/merged_barcode05.fastq.gz

OUT=/gpfs01/share/BioinfMSc/life4136_2526/rotation1/group5/NanoPlot/

NanoPlot --fastq $FASTQ \
	--plots hex dot \
	-o $OUT

conda deactivate
