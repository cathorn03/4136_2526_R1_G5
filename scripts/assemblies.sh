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

unicycler -1 $R1 -2 $R2 -o ./short_reads --threads 20
unicycler -l $LONG -o ./long_reads --threads 20
unicycler -1 $SHORT_F -2 $SHORT_R -l $LONG -o ./hybrid --threads 20
#Runs unicyler for all the reads

cd ../long_reads #Enters long reads folder

READS=../short_reads/merged_sr.fastq.gz
ASSEMBLY=../assemblies/long_reads/assembly.fastq
#Creates variables for polishing

minimap2 -a -t 16 $ASSEMBLY $READS > short_vs_assembly.sam #Creates sam file with sequence overlaps
OVERLAPS=./short_vs_assembly.sam #Sets ads a variable for Racon

cd ../assemblies/long_reads #Enters long_read assembly output directory.

racon -t 16 -m 8 -x -6 -g -8 -w 500 $READS $OVERLAPS $ASSEMBLY > sl_polished.fasta #Runs racon
fold -b -w 60 sl_polished.fasta > ml_polished.fasta #Formats reads to be multiline

conda deactivate #Deactivates this env


conda activate quast #Activates env for quast

cd ../ #Enters working directory
mkdir quast 

SHORT=./assemblies/short_reads/assembly.fasta
LONG=./assemblies/long_reads/assembly.fasta
HYBRID=./assemblies/hybrid/assembly.fasta
POLISHED=./assemblies/long_reads/ml_polished.fasta

OUT=./quast
REF=./reference/genome.fna
FET=./referemce/anotated.gff
#Sets variables for quast

quast $SHORT $LONG $HYBRID $POLISHED -o $OUT -r $REF -g $FET
#Runs quast

conda deactivate