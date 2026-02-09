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

source $HOME/.bash_profile
conda activate annotation

mkdir genovi
cd ./genovi


GBK=../annotations/short_reads/PROKKA*.gbk
OUT=./short_reads
genovi -i $GBK -s complete -o $OUT

GBK=../annotations/long_reads/PROKKA*.gbk
OUT=./long_reads
genovi -i $GBK -s complete -o $OUT

GBK=../annotations/hybridPROKKA*.gbk
OUT=./hybrid
genovi -i $GBK -s complete -o $OUT

GBK=../annotations/polished/PROKKA*.gbk
OUT=./polished
genovi -i $GBK -s complete -o $OUT


conda deactivate