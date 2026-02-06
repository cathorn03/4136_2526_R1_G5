#!/bin/bash
#SBATCH --job-name=assemblies
#SBATCH --partition=defq
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=256g
#SBATCH --time=1:00:00
#SBATCH --mail-user=XXXX@nottingham.ac.uk
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end
#SBATCH --output=./slurm-outputs/slurm-%x-%j.out
#SBATCH --error=./slurm-errors/slurm-%x-%j.err

source $HOME/.bash_profile
conda activate assemblies

R1=./short_reads/merged_sr_R1.fastq
R2=./short_reads/merged_sr_R2.fastq
LONG=./long_reads/merged_lr.fastq

mkdir assemlbies
cd assemblies
mkdir short_reads
mkdir long_reads
mkdir hybrid

unicycler -1 $R1 -2 $R2 -o ./short_reads --threads 20
unicycler -l $LONG -o $./long_reads --threads 20
unicycler -1 $SHORT_F -2 $SHORT_R -l $LONG -o ./hybrid --threads 20

conda deactivate

conda activate polish

cd ../long_reads

READS=../short_reads/merged_sr.fastq
ASSEMBLY=../assemblies/long_reads/assembly.fastq

minimap2 -a -t 16 $ASSEMBLY $READS > short_vs_assembly.sam
OVERLAPS=./short_vs_assembly.sam

cd ../assemblies/long_reads

racon -t 16 -m 8 -x -6 -g -8 -w 500 $READS $OVERLAPS $ASSEMBLY > sl_polished.fasta
fold -b -w 60 short_polished.fasta > ml_polished.fasta

conda deactivate

conda activate quast

cd ../
mkdir quast

SHORT=./assemblies/short_reads/assembly.fasta
LONG=./assemblies/long_reads/assembly.fasta
HYBRID=./assemblies/hybrid/assembly.fasta
POLISHED=./assemblies/long_reads/ml_polished.fasta

OUT=./quast
REF=./reference/genome.fna
FET=./referemce/anotated.gff

quast $SHORT $LONG $HYBRID $POLISHED -o $OUT -r $REF -g $FET