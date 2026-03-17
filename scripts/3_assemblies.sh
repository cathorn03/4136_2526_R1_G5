#!/bin/bash
#SBATCH --job-name=assemblies
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

mkdir assemblies
cd assemblies
mkdir short
mkdir long
mkdir hybrid
#Makes outputs directories for the assemblies

R1=../short_reads/merged_sr_R1.fastq.gz
R2=../short_reads/merged_sr_R2.fastq.gz
LONG=../long_reads/merged_lr.fastq.gz
#Sets variables for the assemlbies

unicycler -1 $R1 -2 $R2 -o ./short -t 20
unicycler -l $LONG -o ./long -t 20
unicycler -1 $R1 -2 $R2 -l $LONG -o ./hybrid -t 20
#Runs unicyler for all the reads