#!/bin/bash
#SBATCH --job-name=genovi
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32g
#SBATCH --time=12:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile #Allows conda use
conda activate annotation #Activates annotation env

mkdir genovi #Makes output directory
cd ./genovi #Enters directory


GBK=$(find ../annotations/short -name "PROKKA*.gbk" | head -n 1) #Handles use of wildcard when reading in prokka
OUT=short_reads
genovi -i $GBK -s complete -o $OUT

GBK=$(find ../annotations/long -name "PROKKA*.gbk" | head -n 1)
OUT=long_reads
genovi -i $GBK -s complete -o $OUT

GBK=$(find ../annotations/hybrid -name "PROKKA*.gbk" | head -n 1)
OUT=hybrid
genovi -i $GBK -s complete -o $OUT

GBK=$(find ../annotations/polished -name "PROKKA*.gbk" | head -n 1)
OUT=polished
genovi -i $GBK -s complete -o $OUT
#Runs genovi for each of the assemblies

conda deactivate #Deactivates env